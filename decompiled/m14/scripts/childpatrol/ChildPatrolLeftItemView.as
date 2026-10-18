package childpatrol
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.ChildPatrolEvent;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ChildPatrolManager;
   import mvc.module.childpatrol.ChildPatrolModel;
   import mvc.module.childpatrol.ChildPatrolTowerInfo;
   import mvc.module.children.ChildData;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.TimeDownView;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildPatrolLeftItemView extends Component
   {
      
      protected var _bg:MutipleImage;
      
      protected var _icon:BaseIconView;
      
      protected var _nameTxt:FilterFrameText;
      
      protected var _stateName:FilterFrameText;
      
      protected var _selected:Boolean;
      
      protected var _filter:UIFilter;
      
      private var _time:TimeDownView;
      
      private var _frameType:int;
      
      protected var _data:ChildData;
      
      public function ChildPatrolLeftItemView()
      {
         super();
         initView();
         initEvent();
      }
      
      protected function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolLeftItemView.bg");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolLeftItemView.nameTxt");
         _stateName = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolLeftItemView.stateName");
         _icon = ComponentFactory.Instance.creatCustomObject("ChildPatrolLeftItemView.headIcon");
         _time = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolLeftItemView.UpdateTime");
         _filter = new UIFilter();
         addChild(_bg);
         addChild(_icon);
         addChild(_nameTxt);
         addChild(_stateName);
         addChild(_time);
         buttonMode = true;
         _icon.mouseEnabled = _icon.mouseChildren = false;
      }
      
      protected function initEvent() : void
      {
         addEventListener("click",__itemClickHandler);
         MsgMan.addObserver("ChildEvent.CHILD_INFO",this,__infoHandler);
         ChildPatrolManager.instance.addEventListener("SELECT_DEL_CHILDPATROL",_updateChildItemHandler);
      }
      
      protected function removeEvent() : void
      {
         removeEventListener("click",__itemClickHandler);
         MsgMan.removeObserver("ChildEvent.CHILD_INFO",this,__infoHandler);
         ChildPatrolManager.instance.removeEventListener("SELECT_DEL_CHILDPATROL",_updateChildItemHandler);
      }
      
      private function _updateChildItemHandler(param1:ChildPatrolEvent) : void
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
      
      protected function __infoHandler(param1:String, param2:Object) : void
      {
         refreshView();
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
      }
      
      protected function refreshView() : void
      {
         var _loc4_:ChildTempInfo = null;
         var _loc5_:String = null;
         var _loc3_:ChildPatrolTowerInfo = null;
         var _loc2_:String = null;
         var _loc1_:int = 0;
         if(_data)
         {
            this.tipData = _data;
            _nameTxt.visible = true;
            _stateName.visible = true;
            _bg.visible = true;
            _loc4_ = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(_data.job,_data.growthGrade);
            _loc5_ = _loc4_.JobName;
            _nameTxt.text = _loc5_;
            _icon.icon = PathManager.info.ResourcePath + "icon" + _loc4_.Icon;
            _icon.visible = true;
            if(model.getIsInBottomByChildId(_data.childId))
            {
               enable = false;
            }
            else
            {
               enable = true;
            }
            if(_frameType == ChildFunType.REVOLT && model.selfIdDic && model.selfIdDic[_data.childId])
            {
               enable = false;
               return;
            }
            if(model.getInPatrolByChildId(_data.childId))
            {
               _time.filters = [];
               _loc3_ = model.getInPatrolByChildId(_data.childId);
               _loc2_ = "";
               if(_loc3_.towerId == 100)
               {
                  _stateName.text = LanguageMgr.GetTranslation("childpatrol.ChildPatrolHeadQuartersFrame.titleText");
               }
               else
               {
                  _loc2_ = _loc3_.towerId.toString();
                  _stateName.text = LanguageMgr.GetTranslation("ChildPatrolLeftItemView.stateName.InPatrol",_loc2_);
               }
               _loc1_ = int(model.getInPatrolIndexByChildId(_data.childId));
               if(_loc1_ == ChildFunType.TASK)
               {
                  _time.timeCount = _loc3_.patrolLeftTime;
                  _time.visible = true;
               }
               else if(_loc1_ == ChildFunType.UP_LEVEL || _loc1_ == ChildFunType.QATROL)
               {
                  _time.timeCount = _loc3_.garrisonLeftTime;
                  _time.visible = true;
               }
               else if(_loc1_ == ChildFunType.EXPLORE)
               {
                  _time.timeCount = _loc3_.exploreLeftTime;
                  _time.visible = true;
               }
            }
            else
            {
               _stateName.text = LanguageMgr.GetTranslation("ChildPatrolLeftItemView.stateName.notInPatrol");
            }
         }
      }
      
      protected function __itemClickHandler(param1:MouseEvent) : void
      {
         var _loc3_:ChildTempInfo = null;
         if(!_data || !this.buttonMode)
         {
            return;
         }
         var _loc2_:int = int(model.getCanPatrolChildCount(_frameType,model.headQuartersInfo.level));
         if(_frameType == ChildFunType.QATROL || _frameType == ChildFunType.UP_LEVEL)
         {
            if(model.curSelectTowerInfo.onGarrison)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChildPatrolBottomView.removeChild.alert1"));
               return;
            }
            if(model.curSelectTowerInfo.level >= 9 && _frameType == ChildFunType.UP_LEVEL && model.headQuartersInfo.level < 10)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChildPatrol.ChildPatrolTaskView.towerOpenLV.LimitGrade"));
               return;
            }
         }
         else if(_frameType == ChildFunType.TASK)
         {
            if(model.curSelectTowerInfo.patrolEndTime > playerModel.sysSecond)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChildPatrolBottomView.removeChild.alert2"));
               return;
            }
            if(model.curSelectTowerInfo.level < 10)
            {
               _loc3_ = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(_data.job,_data.growthGrade);
               if(_loc3_ && _loc3_.MasterType == 1)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChildPatrol.ChildPatrolTaskView.towerOpenTask.LimitGrade"));
                  return;
               }
            }
            if(model.curSelectTowerInfo.state != 0)
            {
               return;
            }
         }
         else if(_frameType == ChildFunType.EXPLORE)
         {
            if(model.curSelectTowerInfo.exploreChildId > 0)
            {
               if(model.curSelectTowerInfo.exploreLeftTime > 0)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChildPatrolBottomView.removeChild.alert3"));
               }
               else
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChildPatrolBottomView.removeChild.alert4"));
               }
               return;
            }
         }
         if(model.childIdList && model.childIdList.length >= _loc2_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("child.childpatrol.nospace.alert"));
            return;
         }
         enable = false;
         ChildPatrolManager.instance.sendDispatchEvent("SELECT_ADD_CHILDPATROL",_data);
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function get model() : ChildPatrolModel
      {
         return ChildPatrolManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         this.filters = [];
         _filter = null;
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
         _data = null;
         super.dispose();
      }
   }
}

