package antaeus
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.antaeus.AntaeusAssistantData;
   import yishi.manager.AntaeusManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class AntaeusListItem extends Component implements IManualSize
   {
      
      private var _imgBtn:ScaleFrameImage;
      
      private var _bit1:Bitmap;
      
      private var _imgInvited:MutipleImage;
      
      private var _txtPower:FilterFrameText;
      
      private var _selected:Boolean = false;
      
      private var invited:Boolean = false;
      
      public var clickback:Function;
      
      private var _icon:BaseIconView;
      
      private var _data:AntaeusAssistantData;
      
      private var spMask:Sprite;
      
      public function AntaeusListItem(param1:AntaeusAssistantData)
      {
         super();
         this._data = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _imgBtn = ComponentFactory.Instance.creatComponentByStylename("ui.antaeus.imgBtn");
         _bit1 = ComponentFactory.Instance.creatBitmap("asset.antaeus.str5");
         _imgInvited = ComponentFactory.Instance.creatComponentByStylename("ui.antaeus.imgInvited");
         _txtPower = ComponentFactory.Instance.creatComponentByStylename("ui.antaeus.txtListPlayerPower");
         addChild(_imgBtn);
         addChild(_bit1);
         addChild(_txtPower);
         if(selected)
         {
            _imgBtn.setFrame(3);
         }
         else
         {
            _imgBtn.setFrame(1);
         }
         _icon = ComponentFactory.Instance.creatComponentByStylename("antaeus.playerIcon");
         spMask = createSprite();
         _icon.mask = spMask;
         addChild(_icon);
         buttonMode = true;
         if(_data)
         {
            _txtPower.visible = true;
            _bit1.visible = false;
            _icon.icon = IconFactory.getHeadIcon(_data.showData.player.head,"smallhead",".jpg");
            _icon.visible = true;
            _txtPower.text = LanguageMgr.GetTranslation("antaeus.player.power",_data.power);
         }
         else
         {
            _txtPower.visible = false;
            _bit1.visible = true;
            _icon.icon = 0;
            _icon.visible = false;
         }
         var _loc1_:Boolean = false;
         if(_data)
         {
            _loc1_ = AntaeusManager.instance.model.antaeusData.userId == _data.userId;
         }
         _imgInvited.visible = _loc1_;
         addChild(_imgInvited);
      }
      
      private function createSprite() : Sprite
      {
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(16777215,1);
         _loc1_.graphics.drawCircle(0,0,20);
         _loc1_.graphics.endFill();
         addChild(_loc1_);
         _loc1_.x = 24;
         _loc1_.y = 21;
         return _loc1_;
      }
      
      private function addEvent() : void
      {
         addEventListener("mouseOver",onOver);
         addEventListener("mouseOut",onOut);
         addEventListener("click",onClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseOver",onOver);
         removeEventListener("mouseOut",onOut);
         removeEventListener("click",onClick);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         if(clickback != null && _data)
         {
            clickback.apply(null,[_data]);
            selected = true;
         }
      }
      
      private function onOut(param1:MouseEvent) : void
      {
         if(selected)
         {
            _imgBtn.setFrame(3);
         }
         else
         {
            _imgBtn.setFrame(1);
         }
      }
      
      private function onOver(param1:MouseEvent) : void
      {
         if(selected)
         {
            _imgBtn.setFrame(4);
         }
         else
         {
            _imgBtn.setFrame(2);
         }
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         if(selected)
         {
            _imgBtn.setFrame(3);
            spMask.x = 26;
            spMask.y = 23;
            _txtPower.setFrame(2);
         }
         else
         {
            _imgBtn.setFrame(1);
            spMask.x = 24;
            spMask.y = 21;
            _txtPower.setFrame(1);
         }
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,196,54);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_imgBtn);
         _imgBtn = null;
         ObjectUtils.disposeObject(_bit1);
         _bit1 = null;
         ObjectUtils.disposeObject(_imgInvited);
         _imgInvited = null;
         ObjectUtils.disposeObject(_txtPower);
         _txtPower = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

