package castle.view
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   
   public class CastleDialogView extends Sprite implements Disposeable, IManualSize
   {
      
      private var _back:Scale9CornerImage;
      
      private var _arror:Image;
      
      private var _iocnBack:Bitmap;
      
      private var _icon:Bitmap;
      
      private var _name:FilterFrameText;
      
      private var _content:FilterFrameText;
      
      private var _closeBtn:BaseButton;
      
      private var _type:int;
      
      private var _callBack:Function;
      
      private var _iconMask:MovieClip;
      
      private var _canvas:Bitmap;
      
      private var _container:Sprite;
      
      private var _viewRectangle:Rectangle = new Rectangle(0,0,628,290);
      
      public function CastleDialogView(param1:int, param2:Function)
      {
         super();
         _type = param1;
         _callBack = param2;
         initView();
         initEvent();
         mouseEnabled = false;
         _iconMask.mouseEnabled = _iconMask.mouseChildren = false;
      }
      
      public function get viewRectangle() : Rectangle
      {
         return _viewRectangle;
      }
      
      private function initView() : void
      {
         _container = new Sprite();
         _back = ComponentFactory.Instance.creatComponentByStylename("castle.DialogIconBack");
         _arror = ComponentFactory.Instance.creatComponentByStylename("castle.RoleDialogArror");
         _iocnBack = ComponentFactory.Instance.creatBitmap("asset.castle.DialogIconBack");
         _icon = ComponentFactory.Instance.creatBitmap("asset.castle.DialogIcon_" + _type);
         _name = ComponentFactory.Instance.creatComponentByStylename("castle.DialogName");
         _content = ComponentFactory.Instance.creatComponentByStylename("castle.DialogContent");
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("castle.DialogBtn");
         _iconMask = ComponentFactory.Instance.creatCustomObject("castle.DialogIconMask");
         _container.addChild(_iocnBack);
         _container.addChild(_back);
         _container.addChild(_icon);
         _container.addChild(_arror);
         _container.addChild(_name);
         _container.addChild(_content);
         _icon.mask = _iconMask;
         _container.addChild(_iconMask);
      }
      
      private function initEvent() : void
      {
         _closeBtn.addEventListener("click",__closeHandler);
      }
      
      private function removeEvent() : void
      {
         _closeBtn.removeEventListener("click",__closeHandler);
      }
      
      private function __closeHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      public function setContent(param1:String, param2:int, param3:int) : void
      {
         _name.text = getNameByType();
         _content.text = param1;
         x = param2;
         y = param3;
         var _loc4_:BitmapData = new BitmapData(viewRectangle.width,viewRectangle.height,true,0);
         _loc4_.draw(_container);
         _canvas = new Bitmap(_loc4_);
         addChild(_canvas);
         addChild(_closeBtn);
         LayerManager.Instance.addToLayer(this,7);
      }
      
      private function getNameByType() : String
      {
         switch(_type - 1)
         {
            case 0:
               return LanguageMgr.GetTranslation("castle.view.CastleDialogView.FLOWER_WOMEN");
            case 1:
               return LanguageMgr.GetTranslation("castle.view.CastleDialogView.FLAMAN");
            case 2:
               return LanguageMgr.GetTranslation("castle.view.CastleDialogView.WARRIOR_WOMEN");
            case 3:
               return LanguageMgr.GetTranslation("castle.view.CastleDialogView.SOLDIER");
            case 4:
               return LanguageMgr.GetTranslation("castle.view.CastleDialogView.BUSSINESSMAN");
            case 5:
               return LanguageMgr.GetTranslation("castle.view.CastleDialogView.BINLUO");
            case 6:
               return LanguageMgr.GetTranslation("castle.view.CastleDialogView.SOLDIER_LEADER");
            case 7:
               return LanguageMgr.GetTranslation("castle.view.CastleDialogView.DRUDGERY");
            default:
               return "";
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_callBack != null)
         {
            _callBack();
         }
         _callBack = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_iocnBack);
         _iocnBack = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_name);
         _name = null;
         ObjectUtils.disposeObject(_content);
         _content = null;
         ObjectUtils.disposeObject(_closeBtn);
         _closeBtn = null;
         ObjectUtils.disposeObject(_iconMask);
         _iconMask = null;
         ObjectUtils.disposeObject(_canvas);
         _canvas = null;
         ObjectUtils.disposeObject(_container);
         _container = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

