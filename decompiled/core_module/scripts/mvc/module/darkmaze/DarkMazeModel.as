package mvc.module.darkmaze
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.children.ChildData;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.datas.templates.DarkMazeChildTemplateInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.view.tips.MessageTipManager;
   
   public class DarkMazeModel extends EventDispatcher
   {
      
      public static const NODE_NUMBER:int = 22;
      
      public static const NO_EVENT:int = 0;
      
      public static const COMMON_EVENT:int = 1;
      
      public static const ELITE_EVENT:int = 2;
      
      public static const BOSS_EVENT:int = 3;
      
      public static const SPRING_EVENT:int = 4;
      
      public static const DEMON_EVENT:int = 5;
      
      public static const LIEREN_EVENT:int = 6;
      
      public static const BUY_EVENT:int = 7;
      
      public static const SHAPE_ADJUST:int = 8;
      
      public static const CURRENT_EVENT:int = 9;
      
      public static const OP_ENTER:int = 1;
      
      public static const OP_WALK:int = 2;
      
      public static const OP_PORTAL:int = 3;
      
      public static const OP_EDIT_POS:int = 4;
      
      public static const OP_REVIVE:int = 5;
      
      public static const OP_BUY:int = 6;
      
      public static const OP_LEAVE:int = 7;
      
      public static const UPDATE_SELECT_CHILDINFO:String = "UPDATE_SELECT_CHILDINFO";
      
      public static const MOVE_TO_TARGET_NODE:String = "MOVE_TO_TARGET_NODE";
      
      public static const UPDATE_BUY_INFO:String = "UPDATE_BUY_INFO";
      
      private var _nodeInfoDic:Dictionary;
      
      public var hasWalkedNodeArray:Array = [];
      
      public var currentNodeId:int;
      
      public var targetNodeId:int;
      
      public var currentIndexPosX:int;
      
      public var currentIndexPosY:int;
      
      public var targetIndexPosX:int;
      
      public var targetIndexPosY:int;
      
      public var moveTargetNodeId:int;
      
      public var moveTargetIndexPosX:int;
      
      public var moveTargetIndexPosY:int;
      
      public var moveTargetNodeType:int;
      
      public var currentLayer:int;
      
      public var battleArray:Array = [];
      
      public var battleChildIdList:Array = [];
      
      public var childList:Array = [];
      
      public var lierenList:Vector.<ChildData>;
      
      public var posIndexArray:Array = [{
         "x":1,
         "y":3
      },{
         "x":2,
         "y":2
      },{
         "x":3,
         "y":1
      },{
         "x":3,
         "y":3
      },{
         "x":4,
         "y":2
      },{
         "x":4,
         "y":4
      },{
         "x":5,
         "y":1
      },{
         "x":5,
         "y":3
      },{
         "x":5,
         "y":5
      },{
         "x":6,
         "y":2
      },{
         "x":6,
         "y":4
      },{
         "x":7,
         "y":1
      },{
         "x":7,
         "y":3
      },{
         "x":7,
         "y":5
      },{
         "x":8,
         "y":2
      },{
         "x":8,
         "y":4
      },{
         "x":9,
         "y":1
      },{
         "x":9,
         "y":3
      },{
         "x":9,
         "y":5
      },{
         "x":10,
         "y":2
      },{
         "x":10,
         "y":4
      },{
         "x":11,
         "y":3
      }];
      
      private var _selectedChildId:int;
      
      private var _selctedBuyIndex:int;
      
      public var darkMazeIsOpen:Boolean;
      
      public var passDarkMaze:Boolean;
      
      public var buyInfoArr:Array = [];
      
      private var startShowDate:Date;
      
      private var startGameDate:Date;
      
      public var endGameDate:Date;
      
      private var endShowDate:Date;
      
      public var resetDateArray:Array;
      
      public var startGameStr:String;
      
      public var endGameStr:String;
      
      public var costDiamondCount:int;
      
      public var openStatus:int;
      
      public function DarkMazeModel()
      {
         var _loc3_:int = 0;
         super();
         var _loc4_:Array = ConfigInfoManager.instance.getDarkMazeConfigTime();
         costDiamondCount = ConfigInfoManager.instance.getDarkMazeCostDiamond();
         startGameStr = _loc4_[1];
         endGameStr = _loc4_[2];
         startShowDate = DateFormatter.parse(_loc4_[0],"YYYY-MM-DD hh:mm");
         startGameDate = DateFormatter.parse(_loc4_[1],"YYYY-MM-DD hh:mm");
         endGameDate = DateFormatter.parse(_loc4_[2],"YYYY-MM-DD hh:mm");
         endShowDate = DateFormatter.parse(_loc4_[3],"YYYY-MM-DD hh:mm");
         resetDateArray = [];
         var _loc2_:Array = ConfigInfoManager.instance.getDarkMazeResetTime();
         var _loc1_:int = int(_loc2_.length);
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            resetDateArray.push(DateFormatter.parse(_loc2_[_loc3_],"YYYY-MM-DD hh:mm"));
            _loc3_++;
         }
      }
      
      public function findNearResetTime() : Date
      {
         var _loc2_:Date = null;
         var _loc1_:Date = null;
         var _loc4_:int = 0;
         var _loc3_:Date = PlayerManager.instance.currentPlayerModel.sysCurtime;
         _loc4_ = 0;
         while(_loc4_ < resetDateArray.length)
         {
            _loc2_ = resetDateArray[_loc4_] as Date;
            if(_loc2_ && _loc2_.time > _loc3_.time)
            {
               _loc1_ = _loc2_;
               break;
            }
            _loc4_++;
         }
         return _loc1_;
      }
      
      public function isCanRefresh() : Boolean
      {
         var _loc1_:int = int(resetDateArray.length);
         var _loc2_:Date = resetDateArray[_loc1_ - 1] as Date;
         if(PlayerManager.instance.currentPlayerModel.sysCurtime.time < _loc2_.time)
         {
            return true;
         }
         return false;
      }
      
      public function isOver() : Boolean
      {
         var _loc1_:Number = PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond;
         if(_loc1_ > endGameDate.time / 1000)
         {
            return true;
         }
         return false;
      }
      
      public function checkDarkMaze() : Boolean
      {
         var _loc1_:Number = PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond;
         if(_loc1_ > startShowDate.time / 1000 && _loc1_ < startGameDate.time / 1000)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("darkmaze.topToolsBar.clickTips1"));
            return false;
         }
         if(_loc1_ >= startGameDate.time / 1000 && _loc1_ < endGameDate.time / 1000)
         {
            if(passDarkMaze)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("darkmaze.topToolsBar.clickTips2"));
               return true;
            }
            return true;
         }
         MessageTipManager.instance().show(LanguageMgr.GetTranslation("darkmaze.topToolsBar.clickTips4"));
         return false;
      }
      
      public function get selectedChildId() : int
      {
         return _selectedChildId;
      }
      
      public function set selectedChildId(param1:int) : void
      {
         _selectedChildId = param1;
         dispatchEvent(new Event("UPDATE_SELECT_CHILDINFO"));
      }
      
      public function get selctedBuyIndex() : int
      {
         return _selctedBuyIndex;
      }
      
      public function set selctedBuyIndex(param1:int) : void
      {
         _selctedBuyIndex = param1;
         dispatchEvent(new Event("UPDATE_BUY_INFO"));
      }
      
      public function get nodeInfoDic() : Dictionary
      {
         return _nodeInfoDic;
      }
      
      public function set nodeInfoDic(param1:Dictionary) : void
      {
         _nodeInfoDic = param1;
      }
      
      public function getChildById(param1:int) : ChildData
      {
         var _loc5_:ChildTempInfo = null;
         var _loc4_:ChildData = null;
         var _loc3_:int = Math.abs(param1);
         var _loc2_:DarkMazeChildTemplateInfo = TempleteManager.instance.darkMazeChildTempCate.getTemplateByID(_loc3_);
         if(_loc2_)
         {
            _loc5_ = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(_loc2_.JobType,12);
            if(_loc5_)
            {
               _loc4_ = new ChildData();
               _loc4_.job = _loc5_.JobType;
               _loc4_.name = _loc5_.JobName;
               _loc4_.growthGrade = 12;
               _loc4_.childId = param1;
               _loc4_.state = 1;
               _loc4_.fightValue = getBattleValue(_loc2_);
            }
         }
         return _loc4_;
      }
      
      public function getChildDataById(param1:int) : ChildData
      {
         var _loc2_:ChildData = null;
         if(param1 > 0)
         {
            _loc2_ = ChildManager.instance.model.getChildById(param1);
         }
         else if(param1 < 0)
         {
            _loc2_ = getChildById(param1);
         }
         return _loc2_;
      }
      
      public function childIsAllMaxHp() : Boolean
      {
         var _loc2_:DarkMazeBattleChildInfo = null;
         var _loc3_:int = 0;
         var _loc1_:Boolean = true;
         _loc3_ = 0;
         while(_loc3_ < childList.length)
         {
            _loc2_ = childList[_loc3_] as DarkMazeBattleChildInfo;
            if(_loc2_ && _loc2_.currentHp < _loc2_.totalHp)
            {
               _loc1_ = false;
               break;
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      private function getBattleValue(param1:DarkMazeChildTemplateInfo) : int
      {
         var _loc2_:int = 0;
         if(param1)
         {
            _loc2_ = param1.Attack + param1.Defence + int(param1.MagicAttack * 1.05) + param1.MagicDefence + param1.ForceHit;
            _loc2_ += param1.Live + param1.Parry + (param1.Penetrate + param1.StunAttr) * 20;
            _loc2_ += (param1.ReduceResi + param1.FireResi + param1.WaterResi + param1.ElectResi + param1.WindResi + param1.DarkResi + param1.LightResi) * 10;
         }
         return _loc2_;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function moveToTargetNode(param1:int, param2:int = 0) : void
      {
         moveTargetNodeId = param1;
         moveTargetNodeType = param2;
         moveTargetIndexPosX = posIndexArray[moveTargetNodeId - 1].x;
         moveTargetIndexPosY = posIndexArray[moveTargetNodeId - 1].y;
         dispatchEvent(new Event("MOVE_TO_TARGET_NODE"));
      }
   }
}

