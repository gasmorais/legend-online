package ylex.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.YLExpedtionManger;
   import mvc.module.children.ChildData;
   import mvc.module.ylex.ChildCampInfo;
   import mvc.module.ylex.YLExpedtionModel;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.ChildCampTempTempInfo;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.filter.UIFilter;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.TimeDownView;
   import yishi.view.tips.MessageTipManager;
   
   public class YLExpedtionLeftItemView extends Component
   {
      
      protected var _bg:MutipleImage;
      
      protected var _icon:BaseIconView;
      
      protected var _nameTxt:FilterFrameText;
      
      protected var _stateName:FilterFrameText;
      
      protected var _selected:Boolean;
      
      protected var _filter:UIFilter;
      
      private var _time:TimeDownView;
      
      private var _time2:TimeDownView;
      
      private var _restCdBtn:IconButton;
      
      private var _frameType:int;
      
      protected var _data:ChildData;
      
      private var _ydData:ChildCampInfo;
      
      public function YLExpedtionLeftItemView()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get ydData() : ChildCampInfo
      {
         return _ydData;
      }
      
      public function set ydData(param1:ChildCampInfo) : void
      {
         _ydData = param1;
      }
      
      protected function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolLeftItemView.bg");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolLeftItemView.nameTxt");
         _stateName = ComponentFactory.Instance.creatComponentByStylename("ui.ylexpedtionLeft.stateName");
         _icon = ComponentFactory.Instance.creatCustomObject("ChildPatrolLeftItemView.headIcon");
         _time = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolLeftItemView.UpdateTime");
         _time2 = ComponentFactory.Instance.creatComponentByStylename("ui.ylexpedition.ydRestCdTime");
         _restCdBtn = ComponentFactory.Instance.creatComponentByStylename("ui.ylexpedition.ydRestCdBtn");
         _filter = new UIFilter();
         addChild(_bg);
         addChild(_icon);
         addChild(_nameTxt);
         addChild(_stateName);
         addChild(_time);
         addChild(_time2);
         addChild(_restCdBtn);
         buttonMode = true;
         _icon.mouseEnabled = _icon.mouseChildren = false;
      }
      
      protected function initEvent() : void
      {
         addEventListener("click",__itemClickHandler);
         _restCdBtn.addEventListener("click",restCdHandler);
         NotificationManager.instance.addEventListener("YLExpedtionModel.EVENT_SELECTED_DEL",_updateChildItemHandler);
         _time2.addEventListener("timerDown_complete",timeCompleteHandler);
      }
      
      protected function removeEvent() : void
      {
         removeEventListener("click",__itemClickHandler);
         _restCdBtn.removeEventListener("click",restCdHandler);
         NotificationManager.instance.removeEventListener("YLExpedtionModel.EVENT_SELECTED_DEL",_updateChildItemHandler);
         _time2.removeEventListener("timerDown_complete",timeCompleteHandler);
      }
      
      private function timeCompleteHandler(param1:Event) : void
      {
         _restCdBtn.visible = false;
         _stateName.text = LanguageMgr.GetTranslation("ChildPatrolLeftItemView.stateName.notInPatrol");
         _stateName.setFrame(3);
         _time2.visible = false;
      }
      
      private function restCdHandler(param1:MouseEvent) : void
      {
         var _loc9_:Array = null;
         var _loc10_:int = 0;
         var _loc8_:int = 0;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc11_:String = null;
         param1.stopImmediatePropagation();
         var _loc2_:Number = PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond * 1000;
         var _loc7_:Number = 0;
         if(ylModel.child_list[_data.childId] != null)
         {
            _loc7_ = Number(ylModel.child_list[_data.childId]);
         }
         _loc7_ += YLExpedtionManger.instance.model.energyRecoveryTimeCD * 1000;
         var _loc3_:int = Math.ceil((_loc7_ - _loc2_) / 1000 / 60);
         if(_loc3_ > 0)
         {
            _loc9_ = YLExpedtionManger.instance.model.buyEnergyPoint;
            _loc10_ = Math.ceil(_loc3_ / int(_loc9_[0]));
            _loc8_ = _loc10_ * int(_loc9_[1]);
            _loc4_ = LanguageMgr.GetTranslation("YLExpeditionItem.buyJinli",_loc8_);
            SimpleAlertHelper.instance.data = [energyBuy,_loc8_];
            _loc5_ = LanguageMgr.GetTranslation("public.confirm");
            _loc6_ = LanguageMgr.GetTranslation("public.cancel");
            _loc11_ = LanguageMgr.GetTranslation("public.prompt");
            SimpleAlertHelper.instance.popAlerFrame(_loc11_,_loc4_,_loc5_,_loc6_,true,true);
         }
      }
      
      private function energyBuy(param1:Boolean, param2:Boolean, param3:int) : void
      {
         var _loc4_:int = 0;
         if(param1)
         {
            _loc4_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
            if(_loc4_ >= param3)
            {
               YLExpedtionManger.instance.sendOp(5,_data.childId);
            }
            else
            {
               RechargeAlertMannager.show();
            }
         }
      }
      
      private function _updateChildItemHandler(param1:NotificationEvent) : void
      {
         var _loc2_:ChildData = param1.data as ChildData;
         if(!_data || !_loc2_)
         {
            return;
         }
         if(_loc2_.childId == _data.childId)
         {
            enable = true;
         }
      }
      
      public function set enable(param1:Boolean) : void
      {
         buttonMode = param1;
         if(param1)
         {
            this.filters = [];
         }
         else
         {
            _filter.setGrayFilter(this);
         }
      }
      
      public function set frameType(param1:int) : void
      {
         _frameType = param1;
      }
      
      public function get data() : ChildData
      {
         return _data;
      }
      
      public function set data(param1:ChildData) : void
      {
         restore();
         _data = param1;
         refreshView();
      }
      
      protected function restore() : void
      {
         _nameTxt.text = "";
         _stateName.text = "";
         _nameTxt.visible = false;
         _stateName.visible = false;
         _bg.visible = false;
         _icon.visible = false;
         _time.visible = false;
         _time.timeCount = 0;
         _restCdBtn.visible = false;
         _time2.visible = false;
         _time2.timeCount = 0;
      }
      
      protected function refreshView() : void
      {
         var _loc7_:ChildTempInfo = null;
         var _loc9_:String = null;
         var _loc3_:ChildCampInfo = null;
         var _loc1_:Number = NaN;
         var _loc5_:ChildCampTempTempInfo = null;
         var _loc6_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc8_:int = 0;
         if(_data && _ydData)
         {
            this.tipData = _data;
            _nameTxt.visible = true;
            _stateName.visible = true;
            _bg.visible = true;
            _loc7_ = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(_data.job,_data.growthGrade);
            _loc9_ = _loc7_.JobName;
            _nameTxt.text = _loc9_;
            _icon.icon = PathManager.info.ResourcePath + "icon" + _loc7_.Icon;
            _icon.visible = true;
            _loc3_ = ylModel.getCampInfoByChildId(_data.childId);
            _loc1_ = PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond * 1000;
            if(_loc3_)
            {
               enable = false;
               _loc5_ = TempleteManager.instance.childCampTempCate.getTempByGrade(_loc3_.grade);
               _loc6_ = _loc3_.startTime + _loc5_.StationedTime * 1000;
               _loc2_ = _loc6_ - _loc1_;
               if(_loc2_ < 0)
               {
                  _loc2_ = 0;
               }
               _stateName.setFrame(1);
               _stateName.text = LanguageMgr.GetTranslation("YLXpedtionYeildFrame.titleText",_loc3_.id);
               _time.timeCount = _loc2_ / 1000;
               _time.visible = true;
            }
            else
            {
               enable = true;
               _loc4_ = 0;
               if(ylModel.child_list[_data.childId] != null)
               {
                  _loc4_ = Number(ylModel.child_list[_data.childId]);
               }
               _loc4_ += YLExpedtionManger.instance.model.energyRecoveryTimeCD * 1000;
               if(_loc4_ > _loc1_)
               {
                  _stateName.setFrame(2);
                  _stateName.text = LanguageMgr.GetTranslation("YLExpeditionItem.restCd");
                  _restCdBtn.visible = true;
                  _loc8_ = (_loc4_ - _loc1_) / 1000;
                  if(_loc8_ < 0)
                  {
                     _loc8_ = 0;
                  }
                  _time2.timeCount = _loc8_;
                  _time2.visible = true;
               }
               else
               {
                  _stateName.text = LanguageMgr.GetTranslation("ChildPatrolLeftItemView.stateName.notInPatrol");
                  _stateName.setFrame(3);
               }
            }
         }
      }
      
      private function get ylModel() : YLExpedtionModel
      {
         return YLExpedtionManger.instance.model;
      }
      
      protected function __itemClickHandler(param1:MouseEvent) : void
      {
         if(!_data || !this.buttonMode)
         {
            return;
         }
         if(_restCdBtn.visible)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ylexpedition.resetCd"));
            return;
         }
         if(_ydData && (_ydData.childId > 0 || _ydData.opChildData != null))
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("YLExpeditionItem.gotoZhuzha"));
            return;
         }
         enable = false;
         NotificationManager.instance.sendNotification("YLExpedtionModel.EVENT_SELECTED_ADD",_data);
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_stateName);
         _stateName = null;
         if(_time)
         {
            ObjectUtils.disposeObject(_time);
         }
         _time = null;
         if(_time2)
         {
            ObjectUtils.disposeObject(_time2);
         }
         _time2 = null;
         ObjectUtils.disposeObject(_restCdBtn);
         _restCdBtn = null;
         super.dispose();
         _filter = null;
         _data = null;
         _ydData = null;
      }
   }
}

