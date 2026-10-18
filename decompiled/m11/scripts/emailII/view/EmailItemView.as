package emailII.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.EmailEvent;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.controler.EmailControler;
   import mvc.module.emailII.EmailInfo;
   import mvc.module.emailII.EmailModel;
   import mvc.module.star.StarInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.BaseItemView;
   
   public class EmailItemView extends Sprite implements Disposeable, ISelectable
   {
      
      private var _iconBg:Bitmap;
      
      private var _selectedBg:ScaleBitmapImage;
      
      private var _checkBtn:SelectedButton;
      
      private var _deleteBtn:BaseButton;
      
      private var _backImg:ScaleFrameImage;
      
      private var _icon:ScaleFrameImage;
      
      private var _name:FilterFrameText;
      
      private var _gmIcon:Image;
      
      private var _person:FilterFrameText;
      
      private var _leftTime:FilterFrameText;
      
      private var _data:EmailInfo;
      
      private var _selected:Boolean;
      
      private var _checkBtnSelecte:Boolean;
      
      private var _goodsIcon:BaseItemView;
      
      private var _BaseIconView:BaseIconView;
      
      private var _hitArea:Sprite;
      
      protected var _filter:IFilterFormat;
      
      public function EmailItemView()
      {
         super();
         init();
      }
      
      private function get control() : EmailControler
      {
         return FrameControllerManager.instance.emailControler;
      }
      
      private function get model() : EmailModel
      {
         return control.model;
      }
      
      private function init() : void
      {
         _iconBg = ComponentFactory.Instance.creatBitmap("asset.email.EmailItemIconBack");
         _selectedBg = ComponentFactory.Instance.creatComponentByStylename("email.EmailItemBackSelected");
         _checkBtn = ComponentFactory.Instance.creatComponentByStylename("email.EmailItemSelectButton");
         _backImg = ComponentFactory.Instance.creatComponentByStylename("email.EmailItemBack");
         _deleteBtn = ComponentFactory.Instance.creatComponentByStylename("email.EmailItemDeleteButton");
         _icon = ComponentFactory.Instance.creatComponentByStylename("email.IconBack");
         _goodsIcon = ComponentFactory.Instance.creatCustomObject("email.EmailItemBaseIcon");
         _BaseIconView = ComponentFactory.Instance.creatCustomObject("email.EmailItemStarBaseIconIcon");
         _name = ComponentFactory.Instance.creatComponentByStylename("email.EmailItemNameText");
         _person = ComponentFactory.Instance.creatComponentByStylename("email.EmailItemPersonText");
         _gmIcon = ComponentFactory.Instance.creatComponentByStylename("email.ItemGmIcon");
         _leftTime = ComponentFactory.Instance.creatComponentByStylename("email.EmailItemLeftTimeText");
         _hitArea = new Sprite();
         _hitArea.x = 36;
         _hitArea.y = 5;
         _icon.setFrame(1);
         _icon.mouseEnabled = false;
         _icon.mouseChildren = false;
         addChild(_checkBtn);
         addChild(_iconBg);
         _hitArea.addChild(_backImg);
         _hitArea.addChild(_icon);
         _hitArea.addChild(_deleteBtn);
         addChild(_hitArea);
         addChild(_goodsIcon);
         addChild(_BaseIconView);
         addChild(_name);
         addChild(_person);
         _person.setFrame(1);
         addChild(_gmIcon);
         addChild(_leftTime);
         addChild(_selectedBg);
         _backImg.setFrame(1);
         _selectedBg.visible = false;
         _selectedBg.mouseChildren = _selectedBg.mouseEnabled = false;
         _hitArea.graphics.beginFill(0,0);
         _hitArea.graphics.drawRect(0,0,_hitArea.width,_hitArea.height);
         _deleteBtn.tipData = LanguageMgr.GetTranslation("emailII.EmailFrame.delete");
         _filter = new UIFilter();
      }
      
      private function initPersonColor() : void
      {
         if(_data)
         {
            if(_data.SendId > 0)
            {
               _person.setFrame(1);
            }
            else
            {
               _person.setFrame(2);
            }
         }
      }
      
      private function initEvent() : void
      {
         _deleteBtn.addEventListener("click",__deleteHandler);
         _hitArea.addEventListener("click",__openHandler);
         _hitArea.addEventListener("rollOver",__mouseOverHandler);
         _hitArea.addEventListener("rollOut",__mouseOutHandler);
         _checkBtn.addEventListener("click",__selectHandler);
         model.addEventListener("VIEW_ALL_SELECTED",__allSelectedHandler);
      }
      
      private function removeEvent() : void
      {
         if(_deleteBtn)
         {
            _deleteBtn.removeEventListener("click",__deleteHandler);
         }
         if(_hitArea)
         {
            _hitArea.removeEventListener("click",__openHandler);
            _hitArea.removeEventListener("rollOver",__mouseOverHandler);
            _hitArea.removeEventListener("rollOut",__mouseOutHandler);
         }
         if(_checkBtn)
         {
            _checkBtn.removeEventListener("click",__selectHandler);
         }
         model.removeEventListener("VIEW_ALL_SELECTED",__allSelectedHandler);
      }
      
      private function __deleteHandler(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         control.deleteEmails([_data.Id]);
      }
      
      private function __mouseOutHandler(param1:MouseEvent) : void
      {
         if(outIndex == 3)
         {
            _filter.setLightingFilter(_iconBg);
         }
         else
         {
            _filter.setNormalFilter(_iconBg);
         }
         _backImg.setFrame(outIndex);
      }
      
      private function get outIndex() : int
      {
         if(_data)
         {
            if(selected)
            {
               return 3;
            }
            if(_data.isRead)
            {
               return 2;
            }
            return 1;
         }
         return 2;
      }
      
      private function __mouseOverHandler(param1:MouseEvent) : void
      {
         _backImg.setFrame(overIndex);
         if(overIndex == 3)
         {
            _filter.setLightingFilter(_iconBg);
         }
         else
         {
            _filter.setNormalFilter(_iconBg);
         }
      }
      
      private function get overIndex() : int
      {
         if(_data)
         {
            return 3;
         }
         return 2;
      }
      
      private function __openHandler(param1:MouseEvent) : void
      {
         model.currentReadEmail = _data;
         if(_data.isRead)
         {
            control.openReadMailFrame();
         }
         else
         {
            control.readEmail(_data.Id);
         }
      }
      
      private function __selectHandler(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         checkBtnSelecte = !checkBtnSelecte;
         if(checkBtnSelecte)
         {
            model.addSelected(_data.Id);
         }
         else
         {
            model.deleteSelected(_data.Id);
         }
      }
      
      private function __allSelectedHandler(param1:EmailEvent) : void
      {
         if(_data)
         {
            checkBtnSelecte = model.allSelected;
         }
      }
      
      public function set data(param1:EmailInfo) : void
      {
         removeEvent();
         _data = param1;
         refresh();
         initPersonColor();
      }
      
      public function get data() : EmailInfo
      {
         return _data;
      }
      
      private function clean() : void
      {
         _name.text = "";
         _person.text = "";
         _leftTime.text = "";
         _checkBtn.selected = false;
         _checkBtn.enable = false;
         _deleteBtn.visible = false;
         _icon.visible = false;
         checkBtnSelecte = false;
         _selectedBg.visible = false;
         buttonMode = false;
         _goodsIcon.data = null;
         _BaseIconView.icon = null;
         _gmIcon.visible = false;
         _BaseIconView.tipData = null;
         setBackImg();
      }
      
      private function setBackImg() : void
      {
         _backImg.buttonMode = _data ? true : false;
         _backImg.setFrame(outIndex);
      }
      
      private function refresh() : void
      {
         clean();
         if(_data)
         {
            buttonMode = true;
            initEvent();
            _name.setFrame(_data.isRead ? 2 : 1);
            _name.text = _data.Title;
            _person.text = getContent() ? getContent() : "";
            _leftTime.text = LanguageMgr.GetTranslation("emailII.view.EmailItemView.leftTime",_data.leftTime);
            _checkBtn.enable = true;
            _deleteBtn.visible = true;
            _icon.visible = true;
            setBackImg();
            setIcon();
            if(_data.SendType == 2)
            {
               _gmIcon.visible = true;
               _gmIcon.x = _name.x + _name.textWidth + 5;
            }
         }
      }
      
      private function setIcon() : void
      {
         switch(int(_data.MailType) - 4)
         {
            case 0:
               setStarMail();
               break;
            default:
               setNormalMail();
         }
      }
      
      private function setNormalMail() : void
      {
         var _loc1_:GoodsInfo = _data.getFirstGoodsInfo();
         if(_loc1_)
         {
            _icon.visible = false;
            _goodsIcon.data = _loc1_;
         }
         else if(_data.isRead)
         {
            _icon.setFrame(2);
         }
         else
         {
            _icon.setFrame(1);
         }
      }
      
      private function setStarMail() : void
      {
         var _loc1_:StarInfo = _data.getFirstStarInfo();
         if(_loc1_ && _loc1_.template)
         {
            _icon.visible = false;
            _BaseIconView.icon = IconFactory.getCommonIconPath(_loc1_.template.Icon);
         }
         else if(_data.isRead)
         {
            _icon.setFrame(2);
         }
         else
         {
            _icon.setFrame(1);
         }
      }
      
      public function getContent() : String
      {
         return LanguageMgr.GetTranslation("emailII.view.EmailItemView.Name",_data.SendNickName);
      }
      
      public function set group(param1:SelectedButtonGroup) : void
      {
         param1.addSelectItem(this);
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         if(param1)
         {
            _selectedBg.visible = _data ? true : false;
            model.selectedMailId = _data ? _data.Id : 0;
            if(_data)
            {
               dispatchEvent(new EmailEvent("EMAIL_SELECTED"));
            }
         }
         else
         {
            _selectedBg.visible = false;
         }
         setBackImg();
         _filter.setNormalFilter(_iconBg);
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_deleteBtn)
         {
            if(_deleteBtn.parent)
            {
               _deleteBtn.parent.removeChild(_deleteBtn);
            }
            _deleteBtn.dispose();
            _deleteBtn = null;
         }
         if(_hitArea)
         {
            if(_hitArea.parent)
            {
               _hitArea.parent.removeChild(_hitArea);
            }
            _hitArea = null;
         }
         if(_icon)
         {
            if(_icon.parent)
            {
               _icon.parent.removeChild(_icon);
            }
            _icon.dispose();
            _icon = null;
         }
         if(_backImg)
         {
            if(_backImg.parent)
            {
               _backImg.parent.removeChild(_backImg);
            }
            _backImg.dispose();
            _backImg = null;
         }
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get checkBtnSelecte() : Boolean
      {
         return _checkBtnSelecte;
      }
      
      public function set checkBtnSelecte(param1:Boolean) : void
      {
         _checkBtn.selected = _checkBtnSelecte = _data && param1 ? true : false;
      }
   }
}

