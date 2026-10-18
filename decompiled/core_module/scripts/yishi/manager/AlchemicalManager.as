package yishi.manager
{
   import com.road.yishi.proto.alchemyworkshop.AlchemyItem;
   import com.road.yishi.proto.alchemyworkshop.AlchemyWorkshopMsg;
   import com.road.yishi.proto.alchemyworkshop.ChildFormulaMsg;
   import com.road.yishi.proto.alchemyworkshop.MineMsg;
   import com.road.yishi.proto.alchemyworkshop.SharedFormulaMsg;
   import mvc.module.alchemical.AlchemicalChildFormulaInfo;
   import mvc.module.alchemical.AlchemicalMakeFormulaInfo;
   import mvc.module.alchemical.AlchemicalMineInfo;
   import mvc.module.alchemical.AlchemicalModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.AlchemicalMineTempInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.MsgMan;
   
   public class AlchemicalManager
   {
      
      private static var _instance:AlchemicalManager;
      
      private var _model:AlchemicalModel;
      
      public function AlchemicalManager()
      {
         super();
         if(!_model)
         {
            _model = new AlchemicalModel();
         }
      }
      
      public static function get instance() : AlchemicalManager
      {
         if(!_instance)
         {
            _instance = new AlchemicalManager();
         }
         return _instance;
      }
      
      public function get model() : AlchemicalModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 461,__alchemicalMsgBackHandler);
      }
      
      private function __alchemicalMsgBackHandler(param1:SLGSocketEvent) : void
      {
         var _loc12_:AlchemicalMineTempInfo = null;
         var _loc9_:AlchemicalMineInfo = null;
         var _loc4_:GoodsInfo = null;
         var _loc11_:AlchemicalMakeFormulaInfo = null;
         var _loc3_:AlchemicalChildFormulaInfo = null;
         var _loc8_:Object = null;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:AlchemyWorkshopMsg = new AlchemyWorkshopMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as AlchemyWorkshopMsg;
         if(_loc2_.hasSpeedTimes)
         {
            model.hasSpeedCount = _loc2_.speedTimes;
         }
         if(_loc2_.hasScore)
         {
            model.curScore = _loc2_.score;
            model.scoreGrade = TempleteManager.instance.getUpgradeGradeBy(139,_loc2_.score);
         }
         if(_loc2_.hasCycleScore)
         {
            model.cycleScore = _loc2_.cycleScore;
         }
         if(_loc2_.mine && _loc2_.mine.length > 0)
         {
            for each(var _loc13_:MineMsg in _loc2_.mine)
            {
               _loc12_ = TempleteManager.instance.alchemicalMineTempCate.getTempInfoById(_loc13_.mineId);
               if(_loc12_)
               {
                  _loc9_ = model.getMineInfoByPos(_loc12_.Pos);
                  if(!_loc9_)
                  {
                     _loc9_ = new AlchemicalMineInfo();
                  }
                  _loc9_.mineId = _loc13_.mineId;
                  _loc9_.pos = _loc12_.Pos;
                  _loc9_.startTime = DateFormatter.parse(_loc13_.startTime,"YYYY-MM-DD hh:mm:ss").time / 1000;
                  model.mineList.push(_loc9_);
               }
            }
            model.mineList.sortOn("pos",16);
            MsgMan.notifyObserver("ALCHEMICAL_MINE_UPDATE");
         }
         if(_loc2_.alchemyItem && _loc2_.alchemyItem.length > 0)
         {
            for each(var _loc5_:AlchemyItem in _loc2_.alchemyItem)
            {
               _loc4_ = model.getAlchemicalItemById(_loc5_.itemId);
               if(!_loc4_)
               {
                  _loc4_ = new GoodsInfo();
                  model.alchemicalItemList.push(_loc4_);
               }
               _loc4_.templateId = _loc5_.itemId;
               _loc4_.count = _loc5_.count;
            }
            model.alchemicalItemList.sortOn("templateId",16);
            MsgMan.notifyObserver("ALCHEMICAL_ITEM_UPDATE");
         }
         if(_loc2_.sharedFormula && (_loc2_.op == 0 || _loc2_.op == 2 || _loc2_.op == 3 || _loc2_.op == 8))
         {
            model.cooperationList = [];
            for each(var _loc10_:SharedFormulaMsg in _loc2_.sharedFormula)
            {
               _loc11_ = new AlchemicalMakeFormulaInfo();
               _loc11_.formulaId = _loc10_.formulaId;
               _loc11_.shareUid = _loc10_.shareUid;
               _loc11_.startTime = DateFormatter.parse(_loc10_.startTime,"YYYY-MM-DD hh:mm:ss").time / 1000;
               for each(var _loc6_:ChildFormulaMsg in _loc10_.childFormula)
               {
                  _loc3_ = new AlchemicalChildFormulaInfo();
                  _loc3_.childIndex = _loc6_.childIndex;
                  _loc3_.userId = _loc6_.userId;
                  _loc3_.nickName = _loc6_.nickName;
                  _loc3_.isAddCatalyst = _loc6_.isAddCatalyst;
                  _loc11_.childFormulaList.push(_loc3_);
               }
               model.cooperationList.push(_loc11_);
            }
            model.cooperationList.sort(sortCooperationList);
            if(model.selectFormulaInfo)
            {
               if(model.selectFormulaInfo.isCooperation)
               {
                  model.selectFormulaInfo = model.getAlchemicalInfoByShareUid(model.selectFormulaInfo.shareUid);
               }
            }
            else
            {
               model.selectFormulaInfo = null;
            }
            MsgMan.notifyObserver("ALCHEMICAL_FORMULA_UPDATE");
         }
         if(_loc2_.op == 8 && _loc2_.opResult == 0 && checkIsRightScene())
         {
            _loc8_ = {};
            _loc8_.index = 1;
            _loc8_.formulaInfo = AlchemicalManager.instance.model.getAlchemicalInfoByShareUid(_loc2_.shareUid);
            FrameControllerManager.instance.openControllerByInfo("alchemical",null,_loc8_);
         }
         MsgMan.notifyObserver("ALCHEMICAL_SELFINFO_UPGATE");
      }
      
      public function sortCooperationList(param1:AlchemicalMakeFormulaInfo, param2:AlchemicalMakeFormulaInfo) : int
      {
         if(param1.isSelfJoin && !param2.isSelfJoin)
         {
            return -1;
         }
         if(!param1.isSelfJoin && param2.isSelfJoin)
         {
            return 1;
         }
         return param1.startTime < param2.startTime ? -1 : 1;
      }
      
      public function sendAlchemicalOpenRequest() : void
      {
         var _loc2_:PackageOut = new PackageOut(9661);
         var _loc1_:AlchemyWorkshopMsg = new AlchemyWorkshopMsg();
         _loc1_.op = 0;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function sendAlchemicalMineRequest(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(9661);
         var _loc3_:AlchemyWorkshopMsg = new AlchemyWorkshopMsg();
         _loc3_.op = param1;
         _loc3_.mineId = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function sendAlchemicalSelfFormula(param1:int, param2:Boolean, param3:int = -1) : void
      {
         var _loc5_:PackageOut = new PackageOut(9661);
         var _loc4_:AlchemyWorkshopMsg = new AlchemyWorkshopMsg();
         _loc4_.op = 2;
         _loc4_.formulaId = param1;
         _loc4_.isAddCatalyst = param2;
         if(param3 != -1)
         {
            _loc4_.childIndex = param3;
         }
         SocketSendManager.instance.sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public function sendAlchemicalSharedFormula(param1:int, param2:Boolean, param3:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(9661);
         var _loc4_:AlchemyWorkshopMsg = new AlchemyWorkshopMsg();
         _loc4_.op = 3;
         _loc4_.shareUid = param1;
         _loc4_.isAddCatalyst = param2;
         _loc4_.childIndex = param3;
         SocketSendManager.instance.sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public function sendAlchemicalSharedInvite(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9661);
         var _loc2_:AlchemyWorkshopMsg = new AlchemyWorkshopMsg();
         _loc2_.op = 4;
         _loc2_.shareUid = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendAlchemicalSharedByChat(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9661);
         var _loc2_:AlchemyWorkshopMsg = new AlchemyWorkshopMsg();
         _loc2_.op = 8;
         _loc2_.shareUid = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      private function checkIsRightScene() : Boolean
      {
         if(SceneManager.instance.currentType == "CASTLE_SCENE" || SceneManager.instance.currentType == "SPACE_SCENE")
         {
            return true;
         }
         return false;
      }
   }
}

