package newactiveleed
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.DayGuideManager;
   import managers.NewActiveLeedManager;
   import mvc.module.newactiveleed.NewActiveLeedModel;
   import yishi.datas.templates.NewActiveLeedInfo;
   import yishi.filter.UIFilter;
   
   public class NewActiveLeedItem extends Component
   {
      
      private var _bg:Bitmap;
      
      private var _tagBg:Bitmap;
      
      private var _icon:Bitmap;
      
      private var _txt:FilterFrameText;
      
      private var _titleTxt:FilterFrameText;
      
      private var _descTxt:FilterFrameText;
      
      private var _timeTxt:FilterFrameText;
      
      private var _timeNumTxt:FilterFrameText;
      
      private var _countTxt:FilterFrameText;
      
      private var _gotoBtn:IconButton;
      
      private var _data:NewActiveLeedInfo;
      
      public function NewActiveLeedItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.NewActiveLeedItem.bg");
         _tagBg = ComponentFactory.Instance.creatBitmap("asset.NewActiveLeedItem.tagBg");
         _icon = ComponentFactory.Instance.creatBitmap("asset.NewActiveLeedFrame.iconImg");
         _txt = ComponentFactory.Instance.creatComponentByStylename("NewActiveLeedItem.txt");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("NewActiveLeedItem.titleTxt");
         _descTxt = ComponentFactory.Instance.creatComponentByStylename("NewActiveLeedItem.descTxt");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("NewActiveLeedItem.timeTxt");
         _timeNumTxt = ComponentFactory.Instance.creatComponentByStylename("NewActiveLeedItem.timeNumTxt");
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("NewActiveLeedItem.countTxt");
         _gotoBtn = ComponentFactory.Instance.creatComponentByStylename("NewActiveLeedItem.gotoBtn");
         addChild(_bg);
         addChild(_tagBg);
         addChild(_icon);
         _icon.x = 10;
         _icon.y = 10;
         addChild(_txt);
         addChild(_titleTxt);
         addChild(_descTxt);
         addChild(_timeTxt);
         addChild(_timeNumTxt);
         addChild(_countTxt);
         addChild(_gotoBtn);
         _timeTxt.text = LanguageMgr.GetTranslation("NewActiveLeedItem.timeTxt.text");
         tipStyle = "yishi.view.tips.OneLineTip";
         tipDirctions = "7";
         tipGapV = 40;
         isFollowMouse = false;
      }
      
      private function addEvent() : void
      {
         _gotoBtn.addEventListener("click",__gotoBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         _gotoBtn.removeEventListener("click",__gotoBtnClickHandler);
      }
      
      private function __gotoBtnClickHandler(param1:MouseEvent) : void
      {
         DayGuideManager.instance.switchScene(_data.TaskType);
      }
      
      public function set data(param1:NewActiveLeedInfo) : void
      {
         _data = param1;
         if(!_data)
         {
            return;
         }
         if(_data.TaskType == 98)
         {
            _txt.text = "+" + model.vipNum;
         }
         else
         {
            _txt.text = "+" + _data.Num;
         }
         _titleTxt.text = _data.Title;
         _descTxt.text = _data.Description;
         _timeNumTxt.text = _data.TaskTime;
         if(_data.isComplete)
         {
            _countTxt.text = LanguageMgr.GetTranslation("dayguide.ProjectItem.statusTxt");
            this.filters = [UIFilter.getGrayFilter()];
         }
         else
         {
            _countTxt.htmlText = "<font color=\'#00ff24\'>" + _data.curCount + "</font>" + "/" + _data.PassCount;
            this.filters = [];
         }
         this.tipData = _data.RewardDes;
      }
      
      private function get model() : NewActiveLeedModel
      {
         return NewActiveLeedManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_tagBg);
         _tagBg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeObject(_titleTxt);
         _titleTxt = null;
         ObjectUtils.disposeObject(_descTxt);
         _descTxt = null;
         ObjectUtils.disposeObject(_timeTxt);
         _timeTxt = null;
         ObjectUtils.disposeObject(_timeNumTxt);
         _timeNumTxt = null;
         ObjectUtils.disposeObject(_countTxt);
         _countTxt = null;
         ObjectUtils.disposeObject(_gotoBtn);
         _gotoBtn = null;
         super.dispose();
         _data = null;
      }
   }
}

