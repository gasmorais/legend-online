package dayguide.newleed
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.DayGuideEvent;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.DayGuideManager;
   import managers.VIPManager;
   import mvc.module.dayGuide.LeedInfo;
   import yishi.filter.UIFilter;
   
   public class ActiveLeedItem extends Component
   {
      
      private var _activeText:FilterFrameText;
      
      private var _processText:FilterFrameText;
      
      private var _descText:FilterFrameText;
      
      private var _nameText:FilterFrameText;
      
      private var _lightImage:Image;
      
      private var _back:Image;
      
      private var _goBtn:IconButton;
      
      private var _data:LeedInfo;
      
      public function ActiveLeedItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _activeText = ComponentFactory.Instance.creatComponentByStylename("ActiveLeed.npxj1k_n6_npxj");
         _processText = ComponentFactory.Instance.creatComponentByStylename("ActiveLeed.npxj1k_n4_npxj");
         _descText = ComponentFactory.Instance.creatComponentByStylename("ActiveLeed.npxj1k_n3_npxj");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("ActiveLeed.npxj1k_n2_npxj");
         _lightImage = ComponentFactory.Instance.creatComponentByStylename("ActiveLeed.npxj1k.lightImage");
         _back = ComponentFactory.Instance.creatComponentByStylename("ActiveLeed.npxj1k.back");
         _goBtn = ComponentFactory.Instance.creatComponentByStylename("ActiveLeed.npxj1k.goBtn");
         addChild(_back);
         addChild(_lightImage);
         addChild(_nameText);
         addChild(_descText);
         addChild(_processText);
         addChild(_activeText);
         addChild(_goBtn);
      }
      
      private function addEvent() : void
      {
         _goBtn.addEventListener("click",_goBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_goBtn)
         {
            _goBtn.removeEventListener("click",_goBtnClickHandler);
         }
      }
      
      private function addDataEvent() : void
      {
         if(_data)
         {
            _data.addEventListener("LEEDINFO_CHANGE",__onPropertyChange);
         }
      }
      
      private function removeDataEvent() : void
      {
         if(_data)
         {
            _data.removeEventListener("LEEDINFO_CHANGE",__onPropertyChange);
         }
      }
      
      private function __onPropertyChange(param1:DayGuideEvent) : void
      {
         if(!_data || !_data.templateInfo)
         {
            return;
         }
         if(_data.isComplete)
         {
            _processText.text = LanguageMgr.GetTranslation("dayguide.ProjectItem.statusTxt");
         }
         else
         {
            _processText.htmlText = _data.currentCount + "<font color=\'#e4d29c\'>/" + _data.templateInfo.PassCount + "</font>";
         }
      }
      
      private function _goBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022",false,false);
         DayGuideManager.instance.switchScene(_data.templateId);
      }
      
      public function set data(param1:LeedInfo) : void
      {
         removeDataEvent();
         _data = param1;
         addDataEvent();
         if(_data.templateId == -1)
         {
            _nameText.text = LanguageMgr.GetTranslation("dayGuide.view.ProjectItem.vipLogin");
            _processText.visible = false;
            _activeText.text = LanguageMgr.GetTranslation("dayguide.ProjectItem.addTxt"," + " + VIPManager.Instance.model.vipActivePrivilege);
            this.tipData = null;
         }
         else
         {
            _nameText.text = _data.templateInfo.Title;
            _descText.text = _data.templateInfo.Desc;
            _processText.visible = true;
            _activeText.text = LanguageMgr.GetTranslation("dayguide.ProjectItem.addTxt"," + " + _data.templateInfo.Num);
            if(_data.isComplete)
            {
               _processText.text = LanguageMgr.GetTranslation("dayguide.ProjectItem.statusTxt");
            }
            else
            {
               _processText.htmlText = _data.currentCount + "<font color=\'#e4d29c\'>/" + _data.templateInfo.PassCount + "</font>";
            }
            this.tipData = _data.templateInfo.RewardDesc;
         }
         if(_data && _data.isComplete)
         {
            this.filters = [UIFilter.getGrayFilter()];
         }
         else
         {
            this.filters = [];
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         removeDataEvent();
         ObjectUtils.disposeObject(_activeText);
         _activeText = null;
         ObjectUtils.disposeObject(_processText);
         _processText = null;
         ObjectUtils.disposeObject(_descText);
         _descText = null;
         ObjectUtils.disposeObject(_nameText);
         _nameText = null;
         ObjectUtils.disposeObject(_lightImage);
         _lightImage = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_goBtn);
         _goBtn = null;
         super.dispose();
      }
   }
}

