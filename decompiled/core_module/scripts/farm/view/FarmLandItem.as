package farm.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import farm.FarmManager;
   import farm.FarmModel;
   import farm.data.FarmInfo;
   import farm.data.FarmLandInfo;
   import farm.data.FriendFarmStateInfo;
   import farm.event.FarmEvent;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.resource.ResourceData;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.PlayerEvent;
   import yishi.filter.UIFilter;
   import yishi.manager.ArmyManager;
   import yishi.manager.CursorManagerII;
   import yishi.manager.DragManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.ResourceManager;
   import yishi.utils.IconFactory;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class FarmLandItem extends Component
   {
      
      public var pos:int;
      
      private var _back:MovieClip;
      
      private var _hitMc:MovieClip;
      
      private var _cropIcon:BaseIconView;
      
      private var _grassImg:Bitmap;
      
      private var _grassImgII:Bitmap;
      
      private var _wormImg:Bitmap;
      
      private var _pickImg:Bitmap;
      
      private var _hasOperEffect:MovieClip;
      
      private var _expEffect:MovieClip;
      
      private var _matureEffect:MovieClip;
      
      private var _filter:UIFilter;
      
      private var _isRefreshCursor:Boolean = false;
      
      private var _isOpen:Boolean;
      
      private var _curState:int;
      
      private var _curPhase:int;
      
      private var _data:FarmLandInfo;
      
      public function FarmLandItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatCustomObject("farm.LandItemBack");
         _cropIcon = ComponentFactory.Instance.creatCustomObject("farm.FarmLandItemCropIcon");
         _grassImg = ComponentFactory.Instance.creatBitmap("asset.farm.FarmLandItemGrassImg");
         _grassImgII = ComponentFactory.Instance.creatBitmap("asset.farm.FarmLandItemGrassImgII");
         _wormImg = ComponentFactory.Instance.creatBitmap("asset.farm.FarmLandItemWormImg");
         _pickImg = ComponentFactory.Instance.creatBitmap("asset.farm.FarmLandItemPickImg");
         _hasOperEffect = ComponentFactory.Instance.creatCustomObject("farm.HasOperEffect");
         _expEffect = ComponentFactory.Instance.creatCustomObject("farm.ExpEffect");
         _matureEffect = ComponentFactory.Instance.creatCustomObject("farm.MatureEffect");
         _hitMc = ComponentFactory.Instance.creatCustomObject("farm.LandItem.hitMc");
         _filter = new UIFilter();
         _back.gotoAndStop(1);
         _expEffect.gotoAndStop(1);
         _matureEffect.gotoAndStop(1);
         _matureEffect.mouseEnabled = _matureEffect.mouseChildren = false;
         _grassImgII.visible = false;
         addChild(_back);
         addChild(_grassImgII);
         addChild(_cropIcon);
         addChild(_hitMc);
         this.mouseEnabled = false;
         _expEffect.mouseEnabled = false;
         _hasOperEffect.mouseEnabled = _hasOperEffect.mouseChildren = false;
      }
      
      private function addEvent() : void
      {
         _hitMc.addEventListener("click",__onItemClick);
         _hitMc.addEventListener("rollOver",__onItemOver);
         _hitMc.addEventListener("rollOut",__onItemOut);
      }
      
      private function removeEvent() : void
      {
         _hitMc.removeEventListener("click",__onItemClick);
         _hitMc.removeEventListener("rollOver",__onItemOver);
         _hitMc.removeEventListener("rollOut",__onItemOut);
      }
      
      private function __onItemOut(param1:MouseEvent) : void
      {
         if(!tipData && (!isOpen || !_data))
         {
            return;
         }
         _filter.setNormalFilter(this);
         if(!DragManager.getInstance().isDraging)
         {
            CursorManagerII.instance.resetCursor();
         }
      }
      
      private function __onItemOver(param1:MouseEvent) : void
      {
         if(tipData)
         {
            _filter.setLightingFilter(this);
            buttonMode = true;
            return;
         }
         if(!isOpen || !_data)
         {
            buttonMode = false;
            return;
         }
         if(_data.isSelfLand || _data.hasCrop)
         {
            _filter.setLightingFilter(this);
            buttonMode = true;
         }
         else
         {
            buttonMode = false;
         }
         setCursorByOper(_data.curOper);
      }
      
      private function __onItemClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(!isOpen || !_data)
         {
            return;
         }
         switch(_data.curOper)
         {
            case 1:
               farmManager.openBagFrame();
               break;
            case 14:
               if(checkGoldLimit(_data.cropTemp))
               {
                  return;
               }
               _loc2_ = _data.canBeStolen;
               if(_loc2_ != "")
               {
                  MessageTipManager.instance().show(_loc2_);
                  cleanCanPickEffect();
                  farmManager.updateFarmStateByType(_data.userId,14,false);
                  return;
               }
               if(model.myFarm.dayStealCount >= model.maxDayStealCount)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("farm.view.FarmLandItem.outStealCountTip"));
                  return;
               }
               farmManager.sendFarmOper(_data.userId,14,_data.pos);
               break;
            case 3:
               farmManager.sendFarmOper(_data.userId,3,_data.pos);
               break;
            case 2:
               farmManager.sendFarmOper(_data.userId,2,_data.pos);
               break;
            case 6:
               if(checkGoldLimit(_data.cropTemp))
               {
                  return;
               }
               farmManager.sendFarmOper(_data.userId,6,_data.pos);
               break;
            case 8:
               farmManager.sendFarmOper(_data.userId,8,_data.pos);
               break;
            case 10:
               _loc3_ = LanguageMgr.GetTranslation("farm.view.FarmOperMenu.clearTip");
               _loc3_ = LanguageMgr.GetTranslation("farm.view.FarmOperMenu.DieClearTip");
               _data.isDie ? _loc3_ : (_loc3_);
               SimpleAlertHelper.instance.data = [operResponse,10,_data];
               SimpleAlertHelper.instance.popAlerFrame(LanguageMgr.GetTranslation("public.prompt"),_loc3_,LanguageMgr.GetTranslation("public.confirm"),LanguageMgr.GetTranslation("public.cancel"),true);
               break;
            case 22:
               ShowTipManager.Instance.removeCurrentTip();
               showMenu();
         }
      }
      
      private function operResponse(param1:Boolean, param2:Boolean, param3:int, param4:FarmLandInfo) : void
      {
         if(param1 && param4)
         {
            farmManager.sendFarmOper(param4.userId,param3,param4.pos);
         }
      }
      
      private function checkGoldLimit(param1:GoodsTemplateInfo) : Boolean
      {
         if(param1 && param1.Property2 == -100 && gold.count >= gold.limit)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("farm.view.FarmLandItem.goldLimitTip"));
            return true;
         }
         return false;
      }
      
      private function addLandListener(param1:FarmLandInfo) : void
      {
         if(param1)
         {
            param1.addEventListener("LANDINFO_UPDATE",__landInfoUpdateHandler);
            param1.addEventListener("OPER_BACK",__operBackHandler);
            playerModel.addEventListener("SYSTIME_UPGRADE_SECOND",__timeUpdateHandler);
         }
      }
      
      private function removeLandListener(param1:FarmLandInfo) : void
      {
         if(param1)
         {
            param1.removeEventListener("LANDINFO_UPDATE",__landInfoUpdateHandler);
            param1.removeEventListener("OPER_BACK",__operBackHandler);
            playerModel.removeEventListener("SYSTIME_UPGRADE_SECOND",__timeUpdateHandler);
         }
      }
      
      private function __operBackHandler(param1:FarmEvent) : void
      {
         var _loc2_:FarmInfo = model.curSelectedFarmInfo;
         if(!_data || !_loc2_ || _loc2_.userId != _data.userId)
         {
            return;
         }
         switch(_data.result)
         {
            case 0:
               addExpAndChatTip(_loc2_);
               updateFriendFarmState(_loc2_);
               if(_data.op_type != 1)
               {
                  _isRefreshCursor = true;
               }
               break;
            case 1:
               showFailTip();
               updateFriendFarmState(_loc2_);
         }
      }
      
      private function addExpAndChatTip(param1:FarmInfo) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = model.expByOper(_data.op_type);
         _expEffect.gotoAndStop("expEffect");
         if(_loc3_ <= 0)
         {
            switch(model.fullExpType - 1)
            {
               case 0:
                  _expEffect["expTxt"]["text"].text = LanguageMgr.GetTranslation("farm.view.FarmLandItem.farmExpFull");
                  break;
               case 1:
                  _expEffect["expTxt"]["text"].text = LanguageMgr.GetTranslation("farm.view.FarmLandItem.dayGpFull");
            }
         }
         else
         {
            _expEffect["expTxt"]["text"].text = LanguageMgr.GetTranslation("farm.view.FarmLandItem.farmExp") + "+" + _loc3_;
            _expEffect["expTxt"]["text"].setTextFormat(ComponentFactory.Instance.model.getSet("farm.FarmExp"));
         }
         switch(_data.op_type - 2)
         {
            case 0:
               _hasOperEffect.play();
               _expEffect.play();
               addChild(_hasOperEffect);
               addChild(_expEffect);
               break;
            case 1:
               _hasOperEffect.play();
               _expEffect.play();
               addChild(_hasOperEffect);
               addChild(_expEffect);
               break;
            case 6:
               _hasOperEffect.play();
               _expEffect.play();
               addChild(_hasOperEffect);
               addChild(_expEffect);
               break;
            case 7:
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("farm.view.FarmLandItem.accelerateSucceed"));
               break;
            case 12:
               _hasOperEffect.play();
         }
         model.myFarm.gp += _loc3_;
         if(!checkIsSelf(param1.userId))
         {
            model.myFarm.dayGpFromFriend += _loc3_;
            _loc2_ = _data.cropTemp ? _data.cropTemp.TemplateName : "";
            farmManager.addChatTip(2,_data.op_type,param1.userId,param1.nickName,_loc2_,_loc3_);
         }
         else
         {
            farmManager.addChatTip(1,_data.op_type,0,"","",_loc3_);
         }
      }
      
      private function updateFriendFarmState(param1:FarmInfo) : void
      {
         if(checkIsSelf(param1.userId))
         {
            return;
         }
         var _loc2_:Boolean = false;
         var _loc4_:FriendFarmStateInfo = model.getFarmStateInfo(param1.userId);
         for each(var _loc3_:FarmLandInfo in param1.getLandList())
         {
            if(farmManager.checkHasOperNow(_loc3_,_data.op_type))
            {
               _loc2_ = true;
            }
         }
         _loc4_.beginChanges();
         switch(_data.op_type - 2)
         {
            case 0:
               _loc4_.canWorm = _loc2_;
               break;
            case 1:
               _loc4_.canWeed = _loc2_;
               break;
            case 6:
               if(_data.canBeStolen == "")
               {
                  _loc4_.canFarmSteal = true;
               }
               _loc4_.canRevive = _loc2_;
               break;
            case 12:
               _loc4_.canFarmSteal = _loc2_;
         }
         _loc4_.commitChanges();
      }
      
      private function showFailTip() : void
      {
         var _loc1_:String = "";
         switch(_data.op_type - 2)
         {
            case 0:
               _loc1_ = LanguageMgr.GetTranslation("farm.FarmManager.noWormTip");
               break;
            case 1:
               _loc1_ = LanguageMgr.GetTranslation("farm.FarmManager.noWeedTip");
               break;
            case 6:
               _loc1_ = LanguageMgr.GetTranslation("farm.FarmManager.noReviveTip");
               break;
            case 12:
               if(!_data.hasCrop)
               {
                  _loc1_ = LanguageMgr.GetTranslation("farm.data.FarmLandInfo.noCrop");
               }
               else if(_data.canBeStolen != "")
               {
                  _loc1_ = _data.canBeStolen;
                  cleanCanPickEffect();
                  farmManager.updateFarmStateByType(_data.userId,14,false);
               }
               break;
            default:
               _loc1_ = LanguageMgr.GetTranslation("farm.FarmManager.noOperTip");
         }
         MessageTipManager.instance().show(_loc1_);
      }
      
      private function __timeUpdateHandler(param1:PlayerEvent) : void
      {
         refreshView(false);
      }
      
      private function __landInfoUpdateHandler(param1:FarmEvent) : void
      {
         refreshView(true);
         updateFriendFarmState(model.curSelectedFarmInfo);
      }
      
      private function refreshView(param1:Boolean) : void
      {
         var _loc2_:String = null;
         if(_data)
         {
            if(_data.hasCrop && _data.cropTemp)
            {
               _loc2_ = IconFactory.getCropIcon(_data.cropTemp,_data.cropPhase);
               _cropIcon.icon == _loc2_ ? _cropIcon.icon : (_cropIcon.icon = _loc2_);
               _cropIcon.tipData = _data;
            }
            else
            {
               _cropIcon.icon = null;
               _cropIcon.tipData = null;
            }
            refreshViewByStatePhase(_data.cropState,_data.cropPhase,param1);
            if(_isRefreshCursor)
            {
               _isRefreshCursor = false;
               setCursorByOper(_data.curOper);
            }
         }
      }
      
      private function clean() : void
      {
         _curState = _curPhase = -1;
         _cropIcon.icon = null;
         _cropIcon.tipData = null;
         cleanEffect();
      }
      
      private function refreshViewByStatePhase(param1:int, param2:int, param3:Boolean) : void
      {
         var _loc4_:DisplayObject = null;
         if(!param3 && _curState == param1 && _curPhase == param2)
         {
            return;
         }
         _curState = param1;
         cleanEffect();
         if(_data.isDie)
         {
            return;
         }
         switch(param1 - 3)
         {
            case 0:
               _loc4_ = _wormImg;
               farmManager.updateFarmStateByType(_data.userId,2,true);
               break;
            case 1:
               _loc4_ = _grassImg;
               _grassImgII.visible = true;
               farmManager.updateFarmStateByType(_data.userId,3,true);
         }
         if(_loc4_ != null)
         {
            _hasOperEffect.gotoAndStop("hasOperEffect");
            _hasOperEffect["hasOperBox"]["box"].addChild(_loc4_);
            addChild(_hasOperEffect);
            return;
         }
         _curPhase = param2;
         switch(param2 - 1)
         {
            case 0:
               cleanEffect();
               break;
            case 1:
               if(_curState != 3 && _curState != 4)
               {
                  cleanEffect();
               }
               break;
            case 2:
               cleanEffect();
               if(!_data.is_grass && !_data.is_worm)
               {
                  if(_data.canBeStolen == "" || checkIsSelf(_data.userId))
                  {
                     _loc4_ = _pickImg;
                     farmManager.updateFarmStateByType(_data.userId,14,true);
                  }
                  addChild(_matureEffect);
                  _matureEffect.gotoAndPlay(1);
               }
               break;
            case 3:
               cleanEffect();
               farmManager.updateFarmStateByType(_data.userId,8,true);
         }
         if(!_loc4_)
         {
            return;
         }
         _hasOperEffect.gotoAndStop("hasOperEffect");
         _hasOperEffect["hasOperBox"]["box"].addChild(_loc4_);
         addChild(_hasOperEffect);
      }
      
      private function cleanEffect() : void
      {
         _hasOperEffect.stop();
         _matureEffect.stop();
         if(_wormImg.parent)
         {
            _wormImg.parent.removeChild(_wormImg);
         }
         if(_grassImg.parent)
         {
            _grassImg.parent.removeChild(_grassImg);
         }
         if(_pickImg.parent)
         {
            _pickImg.parent.removeChild(_pickImg);
         }
         if(_hasOperEffect.parent)
         {
            _hasOperEffect.parent.removeChild(_hasOperEffect);
         }
         if(_matureEffect.parent)
         {
            _matureEffect.parent.removeChild(_matureEffect);
         }
         _grassImgII.visible = false;
      }
      
      private function cleanCanPickEffect() : void
      {
         _hasOperEffect.stop();
         if(_pickImg.parent)
         {
            _pickImg.parent.removeChild(_pickImg);
         }
         if(_hasOperEffect.parent)
         {
            _hasOperEffect.parent.removeChild(_hasOperEffect);
         }
      }
      
      private function showMenu() : void
      {
         var _loc1_:Point = localToGlobal(new Point(_cropIcon.x,_cropIcon.y));
         var _loc2_:FarmOperMenu = new FarmOperMenu();
         _loc2_.data = _data;
         _loc2_.x = _loc1_.x;
         _loc2_.y = _loc1_.y;
         _loc2_.show();
      }
      
      private function setCursorByOper(param1:int) : void
      {
         if(DragManager.getInstance().isDraging || DoubleClickManager.Instance.isClicking)
         {
            return;
         }
         switch(param1 - 2)
         {
            case 0:
               CursorManagerII.instance.showCursorByType("FARM_WORM_CURSOR");
               break;
            case 1:
               CursorManagerII.instance.showCursorByType("FARM_WEED_CURSOR");
               break;
            case 4:
            case 12:
               CursorManagerII.instance.showCursorByType("FARM_PICK_CURSOR");
               break;
            case 6:
               CursorManagerII.instance.showCursorByType("FARM_REVIVE_CURSOR");
               break;
            case 8:
               CursorManagerII.instance.showCursorByType("FARM_CLEAR_CURSOR");
               break;
            default:
               CursorManagerII.instance.resetCursor();
         }
      }
      
      public function set data(param1:FarmLandInfo) : void
      {
         if(_data == param1)
         {
            return;
         }
         clean();
         removeLandListener(_data);
         _data = param1;
         addLandListener(_data);
         refreshView(true);
      }
      
      public function get data() : FarmLandInfo
      {
         return _data;
      }
      
      public function get isOpen() : Boolean
      {
         return _isOpen;
      }
      
      public function set isOpen(param1:Boolean) : void
      {
         if(_isOpen == param1)
         {
            return;
         }
         _isOpen = param1;
         if(_back)
         {
            _isOpen ? _back.gotoAndStop(2) : _back.gotoAndStop(1);
         }
      }
      
      public function set someVisible(param1:Boolean) : void
      {
         param1 ? (_grassImgII.alpha = 1) : (_grassImgII.alpha = 0);
         _cropIcon.visible = _hasOperEffect.visible = _matureEffect.visible = param1;
      }
      
      public function get back() : MovieClip
      {
         return _back;
      }
      
      private function checkIsSelf(param1:int) : Boolean
      {
         return param1 == thane.userId;
      }
      
      private function get model() : FarmModel
      {
         return FarmManager.instance.model;
      }
      
      private function get farmManager() : FarmManager
      {
         return FarmManager.instance;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get gold() : ResourceData
      {
         return ResourceManager.instance.gold;
      }
      
      override public function set tipData(param1:Object) : void
      {
         super.tipData = param1;
      }
      
      override public function dispose() : void
      {
         removeLandListener(_data);
         removeEvent();
         if(_back)
         {
            _back.stop();
         }
         _back = null;
         if(_cropIcon)
         {
            _cropIcon.dispose();
         }
         _cropIcon = null;
         if(_hasOperEffect)
         {
            _hasOperEffect.stop();
         }
         _hasOperEffect = null;
         if(_expEffect)
         {
            _expEffect.stop();
         }
         _expEffect = null;
         if(_matureEffect)
         {
            _matureEffect.stop();
         }
         _matureEffect = null;
         if(_hitMc)
         {
            ObjectUtils.disposeViolentMc(_hitMc);
         }
         _hitMc = null;
         _grassImg = null;
         _grassImgII = null;
         _wormImg = null;
         _pickImg = null;
         _filter = null;
         _data = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

