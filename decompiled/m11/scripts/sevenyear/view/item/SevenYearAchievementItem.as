package sevenyear.view.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.active.anniversary.SevenYearAchievementMsg;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.SevenYearManager;
   import mvc.module.sevenyear.SevenYearModel;
   import yishi.datas.templates.SevenYearAchievementTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.SimpleDictionary;
   import yishi.view.base.ProgressPanel;
   import yishi.view.community.BaseIconView;
   
   public class SevenYearAchievementItem extends Component
   {
      
      private var _bg:MutipleImage;
      
      private var _icon:BaseIconView;
      
      private var _desc:FilterFrameText;
      
      private var _progressPanel:ProgressPanel;
      
      private var _name:FilterFrameText;
      
      private var _btn:IconButton;
      
      private var _iconTxt:FilterFrameText;
      
      private var _hbox:HBox;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _type:int;
      
      private var _data:SevenYearAchievementTempInfo;
      
      private var _achievementMsg:SevenYearAchievementMsg;
      
      private var _imgReceived:Image;
      
      private var _achievedCount:int;
      
      private var _tipIcon:Image;
      
      public function SevenYearAchievementItem(param1:int)
      {
         super();
         _type = param1;
         initView();
         initEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("SevenYearAchievementItem.bg");
         _icon = ComponentFactory.Instance.creatCustomObject("SevenYearAchievementItem.icon");
         _desc = ComponentFactory.Instance.creatComponentByStylename("SevenYearAchievementItem.desc");
         _progressPanel = ComponentFactory.Instance.creatCustomObject("SevenYearAchievementItem.progress");
         _name = ComponentFactory.Instance.creatComponentByStylename("SevenYearAchievementItem.name");
         _btn = ComponentFactory.Instance.creatComponentByStylename("SevenYearAchievementItem.btn");
         _iconTxt = ComponentFactory.Instance.creatComponentByStylename("SevenYearAchievementItem.iconTxt");
         _hbox = ComponentFactory.Instance.creatComponentByStylename("SevenYearAchievementItem.hBox");
         _imgReceived = ComponentFactory.Instance.creatComponentByStylename("SevenYearAchievementItem.received");
         _tipIcon = ComponentFactory.Instance.creatComponentByStylename("SevenYear.icontip");
         _tipIcon.x = 195;
         _tipIcon.y = 120;
         addChild(_bg);
         addChild(_icon);
         addChild(_desc);
         addChild(_progressPanel);
         addChild(_name);
         addChild(_btn);
         addChild(_iconTxt);
         addChild(_hbox);
         addChild(_imgReceived);
         addChild(_tipIcon);
         _tipIcon.tipData = LanguageMgr.GetTranslation("SevenYearGradeView.icon.tip");
         _progressPanel.initView("asset.SevenYearAchievementView.progressBack","asset.SevenYearAchievementView.progressBar","SevenYearAchievementItem.progressTxt");
         _progressPanel.barPosxy(5,5);
         _btnGroup = new SelectedButtonGroup();
         _imgReceived.visible = false;
      }
      
      public function refreshView() : void
      {
         var _loc2_:SelectedIconButton = null;
         var _loc1_:int = 0;
         var _loc6_:SevenYearAchievementTempInfo = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _hbox.removeAllChild();
         _btnGroup.removeAllItem();
         _btnGroup.selectIndex = -1;
         _achievedCount = 0;
         _achievementMsg = model.achievements[_type];
         var _loc5_:SimpleDictionary = TempleteManager.instance.sevenYearAchievementTempCate.getTempInfoArrByType(_type);
         if(_loc5_)
         {
            _loc3_ = 1;
            while(_loc3_ <= _loc5_.keys.length)
            {
               _loc6_ = _loc5_[_loc3_];
               _loc6_.Desc;
               if(_achievementMsg && _achievementMsg.progress >= _loc6_.Target)
               {
                  _achievedCount = _achievedCount + 1;
               }
               _loc4_ = getState(_loc6_);
               if(_loc4_ == 1)
               {
                  if(_loc1_ == 0)
                  {
                     _loc1_ = _loc3_;
                  }
               }
               else if(_loc4_ == 2 && _loc3_ == _loc5_.keys.length)
               {
                  _loc1_ = _loc3_;
               }
               _loc2_ = ComponentFactory.Instance.creatComponentByStylename("SevenYearAchievementItem.optionBtn" + _loc4_);
               _hbox.addChild(_loc2_);
               _btnGroup.addSelectItem(_loc2_);
               _loc3_++;
            }
            if(_loc5_.keys.length == 1)
            {
               _loc1_ = 1;
            }
            _btnGroup.selectIndex = _loc1_ - 1;
         }
      }
      
      private function getState(param1:SevenYearAchievementTempInfo) : int
      {
         var _loc3_:SevenYearAchievementTempInfo = null;
         if(_achievementMsg)
         {
            for each(var _loc2_:int in _achievementMsg.rewardGrades)
            {
               if(param1.Grade == _loc2_)
               {
                  return 2;
               }
            }
            _loc3_ = getInfo(param1.Grade - 1);
            if(_loc3_ && _achievementMsg.progress < _loc3_.Target)
            {
               return 3;
            }
            return 1;
         }
         if(param1.Grade > 1)
         {
            return 3;
         }
         return 1;
      }
      
      private function initEvent() : void
      {
         _btnGroup.addEventListener("change",__btnGroupChangeHandler);
         _btn.addEventListener("click",__btnClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_btnGroup)
         {
            _btnGroup.removeEventListener("change",__btnGroupChangeHandler);
         }
         if(_btn)
         {
            _btn.removeEventListener("click",__btnClickHandler);
         }
      }
      
      private function __btnClickHandler(param1:MouseEvent) : void
      {
         if(!_data)
         {
            return;
         }
         SevenYearManager.instance.sendOp(6,"",_data.TemplateId);
         _imgReceived.visible = true;
      }
      
      private function __btnGroupChangeHandler(param1:Event) : void
      {
         var _loc2_:int = _btnGroup.selectIndex + 1;
         _data = getInfo(_loc2_);
         if(!_data)
         {
            _data = getInfo(1);
         }
         _icon.icon = IconFactory.getTecIconByIcon(_data.IconPath);
         _desc.text = _data.Desc;
         _name.text = _data.TemplateName;
         _iconTxt.text = _data.Score.toString();
         if(_achievementMsg)
         {
            _progressPanel.progressValue(_achievementMsg.progress,_data.Target);
         }
         else
         {
            _progressPanel.progressValue(0,_data.Target);
         }
         _btn.enable = btnState;
         var _loc3_:int = getState(_data);
         if(_loc3_ == 2)
         {
            _imgReceived.visible = true;
         }
         else
         {
            _imgReceived.visible = false;
         }
      }
      
      private function get btnState() : Boolean
      {
         if(!_data)
         {
            return false;
         }
         var _loc1_:int = getState(_data);
         if(_loc1_ == 1 && _achievementMsg && _achievementMsg.progress >= _data.Target)
         {
            return true;
         }
         return false;
      }
      
      private function getInfo(param1:int) : SevenYearAchievementTempInfo
      {
         return TempleteManager.instance.sevenYearAchievementTempCate.getTempInfoArrByTypeGrade(_type,param1);
      }
      
      private function get model() : SevenYearModel
      {
         return SevenYearManager.instance.model;
      }
      
      public function get achievedCount() : int
      {
         return _achievedCount;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_desc);
         _desc = null;
         ObjectUtils.disposeObject(_progressPanel);
         _progressPanel = null;
         ObjectUtils.disposeObject(_name);
         _name = null;
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         ObjectUtils.disposeObject(_iconTxt);
         _iconTxt = null;
         ObjectUtils.disposeObject(_hbox);
         _hbox = null;
         ObjectUtils.disposeObject(_btnGroup);
         _btnGroup = null;
         ObjectUtils.disposeObject(_imgReceived);
         _imgReceived = null;
         ObjectUtils.disposeObject(_tipIcon);
         _tipIcon = null;
         super.dispose();
      }
   }
}

