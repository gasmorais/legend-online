package cathouse
{
   import battle.utils.Int64Utils;
   import cathouse.courtyard.CatAvatar;
   import cathouse.courtyard.ToyAvatar;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.cat.CattoysInfoMsg;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import managers.CatHouseManager;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.CatHouseTemplateInfo;
   import yishi.datas.templates.cate.CatHouseTemplateCate;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.BaseTip;
   
   public class CatObjectPutConatiner extends Component
   {
      
      public static const MAX_CAT_COUNT:int = 5;
      
      private var _cycleBlockMC:MovieClip;
      
      private var _toyAvatar:ToyAvatar;
      
      private var _catAvatarList:Vector.<CatAvatar>;
      
      private var _catAvatarPosList:Vector.<Point>;
      
      private var _index:int;
      
      private var _remainTip:BaseTip;
      
      private var _goldTip:BaseTip;
      
      private var _isHarvestTime:Boolean = false;
      
      private var _curMaxCatCount:uint;
      
      private var _isShelf:Boolean;
      
      private var _curCatMsg:CattoysInfoMsg;
      
      private var _layBtn:IconButton;
      
      private var _removeBtn:IconButton;
      
      private var _harvestBtn:IconButton;
      
      public function CatObjectPutConatiner(param1:int)
      {
         _index = param1;
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:CatAvatar = null;
         var _loc1_:int = 0;
         _cycleBlockMC = ComponentFactory.Instance.creatCustomObject("cathouse.CatToyBlock.cycle");
         _cycleBlockMC.gotoAndStop(_isShelf ? 1 : 3);
         addChild(_cycleBlockMC);
         _cycleBlockMC.mouseEnabled = _cycleBlockMC.mouseChildren = false;
         _toyAvatar = new ToyAvatar();
         addChild(_toyAvatar);
         _catAvatarPosList = new Vector.<Point>();
         _catAvatarList = new Vector.<CatAvatar>();
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc2_ = new CatAvatar(_cycleBlockMC.width >> 1);
            _catAvatarList[_loc1_] = _loc2_;
            addChild(_loc2_);
            _loc1_++;
         }
         _remainTip = ComponentFactory.Instance.creatCustomObject("cathouse.MultipleLineTip");
         addChild(_remainTip);
         _remainTip.mouseChildren = _remainTip.mouseEnabled = false;
         _remainTip.visible = false;
         _goldTip = ComponentFactory.Instance.creatCustomObject("cathouse.CatRewardTips");
         addChild(_goldTip);
         _goldTip.mouseChildren = _goldTip.mouseEnabled = false;
         _goldTip.visible = false;
         _layBtn = ComponentFactory.Instance.creatComponentByStylename("cathouse.courtyardLayBtn");
         _removeBtn = ComponentFactory.Instance.creatComponentByStylename("cathouse.courtyardRemoveBtn");
         _harvestBtn = ComponentFactory.Instance.creatComponentByStylename("cathouse.courtyardHarvestBtn");
         addChild(_layBtn);
         addChild(_removeBtn);
         addChild(_harvestBtn);
      }
      
      private function addEvent() : void
      {
         _layBtn.addEventListener("click",__onBtnHandler);
         _removeBtn.addEventListener("click",__onBtnHandler);
         _harvestBtn.addEventListener("click",__onBtnHandler);
      }
      
      private function removeEvent() : void
      {
         _layBtn.removeEventListener("click",__onBtnHandler);
         _removeBtn.removeEventListener("click",__onBtnHandler);
         _harvestBtn.removeEventListener("click",__onBtnHandler);
         _toyAvatar.removeEventListener("rollOver",__rollToyAvatarHandler);
         _toyAvatar.removeEventListener("rollOut",__rollToyAvatarHandler);
      }
      
      public function updateUI(param1:CattoysInfoMsg) : void
      {
         var _loc2_:Array = null;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc7_:CatAvatar = null;
         var _loc3_:CatHouseTemplateInfo = null;
         var _loc5_:int = 0;
         _curCatMsg = param1;
         if(_curCatMsg != null)
         {
            _toyAvatar.templateInfo = TempleteManager.instance.catHouseTemplateCate.getTemplateById(_curCatMsg.templateId);
            _curMaxCatCount = _toyAvatar.templateInfo.CatCount;
            layoutToyAvatar(_toyAvatar);
            if(_toyAvatar.isLoading)
            {
               _toyAvatar.loadedCallbackFun = layoutToyAvatar;
            }
            _loc2_ = [_curCatMsg.catTemplateId,_curCatMsg.catTemplateId1,_curCatMsg.catTemplateId2,_curCatMsg.catTemplateId3,_curCatMsg.catTemplateId4];
            _loc4_ = 0;
            _loc5_ = 0;
            while(_loc5_ < _loc2_.length)
            {
               _loc6_ = int(_loc2_[_loc5_]);
               if(_loc6_ != 0 && _loc4_ < _catAvatarList.length)
               {
                  _loc7_ = _catAvatarList[_loc4_];
                  _loc3_ = TempleteManager.instance.catHouseTemplateCate.getTemplateById(_loc6_);
                  _loc4_++;
                  _loc7_.visible = true;
                  if(_isHarvestTime)
                  {
                     _loc7_.addEventListener("rollOut",__rollCatAvatarHandler);
                     _loc7_.addEventListener("rollOver",__rollCatAvatarHandler);
                  }
                  else
                  {
                     _loc7_.templateInfo = _loc3_;
                     _loc7_.setActionByType(_loc7_.templateInfo.Types);
                     _loc7_.addEventListener("rollOut",__rollCatAvatarHandler);
                     _loc7_.addEventListener("rollOver",__rollCatAvatarHandler);
                  }
                  layoutCatAvatar(_loc7_);
                  if(_loc7_.isLoading)
                  {
                     _loc7_.loadedCallbackFun = layoutCatAvatar;
                  }
               }
               _loc5_++;
            }
            _layBtn.visible = false;
            _removeBtn.visible = false;
            _harvestBtn.visible = false;
            _cycleBlockMC.visible = false;
            if(_curCatMsg.state == 1)
            {
               _removeBtn.visible = true;
            }
            else if(_curCatMsg.state == 2)
            {
               _harvestBtn.visible = true;
            }
            _toyAvatar.addEventListener("rollOver",__rollToyAvatarHandler);
            _toyAvatar.addEventListener("rollOut",__rollToyAvatarHandler);
         }
      }
      
      private function __onBtnHandler(param1:Event) : void
      {
         var _loc6_:int = 0;
         var _loc5_:CatHouseTemplateInfo = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc8_:String = null;
         var _loc4_:String = null;
         SoundManager.instance.play("022");
         var _loc7_:IconButton;
         switch(_loc7_ = param1.currentTarget as IconButton)
         {
            case _layBtn:
               _loc6_ = int(CatHouseTemplateCate.INDEX_TO_TYPE[_index]);
               FrameControllerManager.instance.openControllerByInfo("cathouse",1,_loc6_);
               break;
            case _harvestBtn:
               CatHouseManager.instance.OperateCatHouse(3,0,_curCatMsg.id);
               break;
            case _removeBtn:
               _loc5_ = TempleteManager.instance.catHouseTemplateCate.getTemplateById(_curCatMsg.templateId);
               SimpleAlertHelper.instance.data = [__removeHandler];
               _loc2_ = LanguageMgr.GetTranslation("public.confirm");
               _loc3_ = LanguageMgr.GetTranslation("public.cancel");
               _loc8_ = LanguageMgr.GetTranslation("public.prompt");
               _loc4_ = LanguageMgr.GetTranslation("cathouse.opManager.removeHandler",_loc5_.TemplateName);
               SimpleAlertHelper.instance.popAlerFrame(_loc8_,_loc4_,_loc2_,_loc3_,true,true);
               return;
         }
      }
      
      private function __removeHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            CatHouseManager.instance.OperateCatHouse(4,0,_curCatMsg.id);
         }
      }
      
      private function __rollToyAvatarHandler(param1:MouseEvent) : void
      {
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:String = null;
         var _loc2_:CatHouseTemplateInfo = null;
         var _loc4_:String = null;
         if(!_curCatMsg)
         {
            return;
         }
         if(param1.type == "rollOver")
         {
            _remainTip.visible = true;
            _loc6_ = Int64Utils.int64ToNumber(_curCatMsg.cdTime) / 1000 - playerModel.sysSecond;
            _loc3_ = _loc6_ / 60;
            if(_loc3_ <= 0)
            {
               _loc3_ = 0;
            }
            _loc5_ = LanguageMgr.GetTranslation("map.internals.view.frame.FieldInfoView.remainintTimeFrameTextText") + ":" + (int(_loc3_ / 60) <= 0 ? LanguageMgr.GetTranslation("public.needMinutes",_loc3_ % 60) : LanguageMgr.GetTranslation("public.needHM",int(_loc3_ / 60),_loc3_ % 60));
            _loc2_ = TempleteManager.instance.catHouseTemplateCate.getTemplateById(_curCatMsg.templateId);
            _loc4_ = LanguageMgr.GetTranslation("catHouse.CatToyWarehouseBar.itemTip",_loc2_.TemplateName,_loc2_.OutGold,_loc5_);
            _remainTip.tipData = _loc4_;
         }
         else
         {
            _remainTip.visible = false;
         }
      }
      
      private function __rollCatAvatarHandler(param1:MouseEvent) : void
      {
         _goldTip.tipData = "";
         var _loc2_:CatAvatar = param1.target as CatAvatar;
         if(param1.type == "rollOver")
         {
            _goldTip.visible = true;
            _goldTip.tipData = _loc2_.templateInfo;
            _goldTip.x = _loc2_.x + 20;
            _goldTip.y = _loc2_.y - _goldTip.height;
         }
         else
         {
            _goldTip.visible = false;
         }
      }
      
      private function layoutToyAvatar(param1:ToyAvatar) : void
      {
         var _loc4_:CatAvatar = null;
         var _loc2_:Point = null;
         var _loc3_:* = 0;
         param1.x = _cycleBlockMC.x + _cycleBlockMC.width * 0.5 - param1.centerPos.x;
         param1.y = _cycleBlockMC.y + _cycleBlockMC.height * 0.5 - param1.centerPos.y;
         _remainTip.x = _toyAvatar.x + _toyAvatar.centerPos.x - 20 - _remainTip.width;
         _remainTip.y = _toyAvatar.y + _toyAvatar.centerPos.y - 60 - _remainTip.height;
         if(_index == 1)
         {
            _remainTip.x = 200;
            _remainTip.y = 80;
         }
         if(!param1.isLoading)
         {
            _catAvatarPosList = _toyAvatar.curCatPosList.concat();
            _loc3_ = 0;
            while(_loc3_ < _curMaxCatCount)
            {
               _loc4_ = _catAvatarList[_loc3_];
               if(!_loc4_.isLoading && _loc3_ < _catAvatarPosList.length)
               {
                  _loc2_ = _catAvatarPosList[_loc3_];
                  setCatPosWithOffset(_loc4_,_loc2_);
                  _catAvatarPosList[_loc3_] = null;
               }
               _loc3_++;
            }
         }
      }
      
      private function layoutCatAvatar(param1:CatAvatar) : void
      {
         var _loc2_:Point = null;
         var _loc3_:int = _catAvatarList.indexOf(param1);
         if(_catAvatarPosList != null && _loc3_ >= 0 && _loc3_ < _catAvatarPosList.length)
         {
            _loc2_ = _catAvatarPosList[_loc3_];
            if(_loc2_ != null)
            {
               setCatPosWithOffset(param1,_loc2_);
            }
            _catAvatarPosList[_loc3_] = null;
         }
      }
      
      private function setCatPosWithOffset(param1:CatAvatar, param2:Point) : void
      {
         var _loc3_:Boolean = _toyAvatar.templateInfo == null ? false : _toyAvatar.templateInfo.Types == 105;
         if(!_isHarvestTime && _loc3_ && _toyAvatar.posMCList.length > 0)
         {
            _toyAvatar.posMCList[0].addChild(param1);
            param1.x = param1.y = 0;
         }
         else
         {
            param1.x = _toyAvatar.x + param2.x;
            param1.y = _toyAvatar.y + param2.y;
         }
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function clear() : void
      {
         var _loc2_:CatAvatar = null;
         var _loc1_:int = 0;
         _toyAvatar.templateInfo = null;
         _toyAvatar.clearAvatar();
         _cycleBlockMC.visible = true;
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc2_ = _catAvatarList[_loc1_];
            _loc2_.templateInfo = null;
            _loc2_.clearAvatar();
            _loc1_++;
         }
         _layBtn.visible = true;
         _removeBtn.visible = false;
         _harvestBtn.visible = false;
         _curCatMsg = null;
      }
      
      override public function dispose() : void
      {
         var _loc1_:CatAvatar = null;
         removeEvent();
         if(_catAvatarList)
         {
            while(_catAvatarList.length)
            {
               _loc1_ = _catAvatarList.pop();
               _loc1_.templateInfo = null;
               _loc1_.removeEventListener("rollOut",__rollCatAvatarHandler);
               _loc1_.removeEventListener("rollOver",__rollCatAvatarHandler);
               ObjectUtils.disposeObject(_loc1_);
               _loc1_ = null;
            }
         }
         ObjectUtils.disposeViolentMc(_cycleBlockMC);
         _cycleBlockMC = null;
         ObjectUtils.disposeObject(_toyAvatar);
         _toyAvatar = null;
         ObjectUtils.disposeObject(_loc1_);
         _loc1_ = null;
         ObjectUtils.disposeObject(_remainTip);
         _remainTip = null;
         ObjectUtils.disposeObject(_goldTip);
         _goldTip = null;
         ObjectUtils.disposeObject(_layBtn);
         _layBtn = null;
         ObjectUtils.disposeObject(_loc1_);
         _loc1_ = null;
         ObjectUtils.disposeObject(_removeBtn);
         _removeBtn = null;
         ObjectUtils.disposeObject(_harvestBtn);
         _harvestBtn = null;
         _catAvatarList = null;
         _catAvatarPosList = null;
         _curCatMsg = null;
         super.dispose();
      }
   }
}

