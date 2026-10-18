package child.handin
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.children.ChildData;
   import yishi.utils.MsgMan;
   
   public class ChildHandInItem extends Component
   {
      
      private var _selected:Boolean;
      
      private var _headIcon:ScaleFrameImage;
      
      private var _jobImg:ScaleFrameImage;
      
      private var _selectImg:DisplayObject;
      
      private var _bg:MutipleImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _fightTxt:FilterFrameText;
      
      private var _lookBtn:IconButton;
      
      private var _selectBtn:IconButton;
      
      private var _cancleBtn:IconButton;
      
      private var _data:ChildData;
      
      public function ChildHandInItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ChildHandInItem.bg");
         _headIcon = ComponentFactory.Instance.creatComponentByStylename("ChildHandInItem.headIcon");
         _jobImg = ComponentFactory.Instance.creatComponentByStylename("ChildHandInItem.jobImg");
         _selectImg = ComponentFactory.Instance.creat("asset.core.checkstyle_6.Selected");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("ChildHandInItem.nameTxt");
         _fightTxt = ComponentFactory.Instance.creatComponentByStylename("ChildHandInItem.fightTxt");
         _lookBtn = ComponentFactory.Instance.creatComponentByStylename("ChildHandInItem.lookBtn");
         _selectBtn = ComponentFactory.Instance.creatComponentByStylename("ChildHandInItem.selectBtn");
         _cancleBtn = ComponentFactory.Instance.creatComponentByStylename("ChildHandInItem.cancleBtn");
         addChild(_bg);
         addChild(_headIcon);
         addChild(_jobImg);
         addChild(_selectImg);
         addChild(_nameTxt);
         addChild(_fightTxt);
         addChild(_lookBtn);
         addChild(_selectBtn);
         addChild(_cancleBtn);
         selected = false;
      }
      
      private function unInitView() : void
      {
         ObjectUtils.disposeObject(_headIcon);
         _headIcon = null;
         ObjectUtils.disposeObject(_jobImg);
         _jobImg = null;
         ObjectUtils.disposeObject(_selectImg);
         _selectImg = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_fightTxt);
         _fightTxt = null;
         ObjectUtils.disposeObject(_lookBtn);
         _lookBtn = null;
         ObjectUtils.disposeObject(_selectBtn);
         _selectBtn = null;
         ObjectUtils.disposeObject(_cancleBtn);
         _cancleBtn = null;
         _data = null;
      }
      
      private function refreshView() : void
      {
         _headIcon.setFrame(_data.job);
         _jobImg.visible = true;
         _jobImg.setFrame(_data.job);
         _fightTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.fightingTxt",_data.fightValue);
         _nameTxt.text = _data.name;
      }
      
      private function initEvent() : void
      {
         if(_lookBtn)
         {
            _lookBtn.addEventListener("click",__lookBtnHandler);
         }
         if(_selectBtn)
         {
            _selectBtn.addEventListener("click",__selectBtnHandler);
         }
         if(_cancleBtn)
         {
            _cancleBtn.addEventListener("click",__cancleBtnHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_lookBtn)
         {
            _lookBtn.removeEventListener("click",__lookBtnHandler);
         }
         if(_selectBtn)
         {
            _selectBtn.removeEventListener("click",__selectBtnHandler);
         }
         if(_cancleBtn)
         {
            _cancleBtn.removeEventListener("click",__cancleBtnHandler);
         }
      }
      
      private function __lookBtnHandler(param1:MouseEvent) : void
      {
         ChildManager.instance.lookChildInformationFrame(_data);
      }
      
      private function __selectBtnHandler(param1:MouseEvent) : void
      {
         selected = true;
      }
      
      private function __cancleBtnHandler(param1:MouseEvent) : void
      {
         selected = false;
      }
      
      public function get data() : ChildData
      {
         return _data;
      }
      
      public function set data(param1:ChildData) : void
      {
         _data = param1;
         refreshView();
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         if(_selectImg)
         {
            _selectImg.visible = _selected;
         }
         if(_cancleBtn)
         {
            _cancleBtn.visible = _selected;
         }
         if(_selectBtn)
         {
            _selectBtn.visible = !_selected;
         }
         MsgMan.notifyObserver("ChildEvent.HAND_IN_CHANGE");
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unInitView();
         super.dispose();
      }
   }
}

