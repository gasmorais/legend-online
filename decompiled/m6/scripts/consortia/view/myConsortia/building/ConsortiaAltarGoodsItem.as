package consortia.view.myConsortia.building
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import mvc.module.consortia.ConsortiaModel;
   import mvc.module.consortia.DropViewInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseItemView;
   
   public class ConsortiaAltarGoodsItem extends Sprite implements Disposeable, ISelectable
   {
      
      private var _selected:Boolean;
      
      private var _data:DropViewInfo;
      
      private var _icon:BaseItemView;
      
      private var _profileBg:ScaleFrameImage;
      
      private var _bg:Bitmap;
      
      private var _moveBg:Bitmap;
      
      private var _mask:MovieClip;
      
      private var _flicker:MovieClip;
      
      private var _delayTime:Number;
      
      private var _iconSprite:Sprite;
      
      private var _iconIndex:int;
      
      public function ConsortiaAltarGoodsItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.consortia.altarItemBg");
         _moveBg = ComponentFactory.Instance.creatBitmap("asset.consortia.altarMoveBg");
         _profileBg = ComponentFactory.Instance.creatComponentByStylename("consortia.ContributeItemProfileBg");
         _mask = ComponentFactory.Instance.creat("asset.consortia.altarGoodsMask");
         _flicker = ComponentFactory.Instance.creat("asset.consortia.altarGoodsFlickerEffctMC");
         _moveBg.visible = false;
         _profileBg.setFrame(1);
         _mask.x = 21;
         _mask.y = 21;
         _iconSprite = new Sprite();
         _icon = ComponentFactory.Instance.creatCustomObject("consortia.AlatarGoodsItem");
         setIcon();
         _flicker.x = _moveBg.x + 8;
         _flicker.y = _moveBg.y + 5;
         _flicker.gotoAndStop(1);
         _flicker.visible = false;
         addChild(_profileBg);
         addChild(_moveBg);
         addChild(_bg);
         addChild(_iconSprite);
         _iconSprite.addChild(_mask);
         _iconSprite.addChild(_icon);
         _iconSprite.addChild(_flicker);
      }
      
      private function setIcon() : void
      {
         _icon.mask = _mask;
      }
      
      private function uninit() : void
      {
         TweenLite.killTweensOf(_moveBg);
         if(_mask)
         {
            ObjectUtils.disposeObject(_mask);
         }
         _mask = null;
         if(_iconSprite)
         {
            ObjectUtils.disposeAllChildren(_iconSprite);
         }
         _iconSprite = null;
         ObjectUtils.disposeAllChildren(this);
         _data = null;
         _icon = null;
      }
      
      public function get data() : DropViewInfo
      {
         return _data;
      }
      
      public function set data(param1:DropViewInfo) : void
      {
         _data = param1;
         resetIconSprite();
         if(_data)
         {
            _icon.icon.icon = IconFactory.getTecIconByIcon(_data.Res);
            _icon.tipData = _data.Names;
         }
         else
         {
            _icon.icon.icon = null;
         }
      }
      
      private function resetIconSprite() : void
      {
         if(_iconSprite.parent != this)
         {
            _flicker.visible = false;
            _iconSprite.scaleX = _iconSprite.scaleY = 1;
            _iconSprite.x = _iconSprite.y = 0;
            addChild(_iconSprite);
         }
      }
      
      public function flicker() : void
      {
         _flicker.visible = true;
         _flicker.gotoAndPlay(1);
         _moveBg.visible = false;
      }
      
      public function stopFlicker() : void
      {
         _flicker.visible = false;
         _flicker.gotoAndStop(1);
      }
      
      public function dispose() : void
      {
         uninit();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         _delayTime = model.delayTime * 0.002;
         if(_selected)
         {
            _moveBg.alpha = 1;
            _moveBg.visible = true;
            _delayTime = model.delayTime > 400 ? 0.8 : model.delayTime * 0.002;
            if(_delayTime)
            {
               setTween();
            }
         }
         else if(!_delayTime)
         {
            _moveBg.visible = false;
         }
      }
      
      private function setTween() : void
      {
         TweenLite.killTweensOf(_moveBg);
         _moveBg.alpha = 0;
         var _loc1_:Number = _delayTime;
         if(_delayTime >= 0.6)
         {
            _loc1_ = 0.3;
         }
         if(_delayTime >= 0.8)
         {
            _loc1_ = 0.05;
         }
         TweenLite.to(_moveBg,_loc1_ + 0.2,{
            "alpha":1,
            "onComplete":hideBg
         });
      }
      
      private function hideBg() : void
      {
         hideMoveBg(_delayTime);
      }
      
      public function hideMoveBg(param1:Number) : void
      {
         TweenLite.to(_moveBg,param1,{"alpha":0});
      }
      
      private function get model() : ConsortiaModel
      {
         return FrameControllerManager.instance.consortiaController.model;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function get iconSprite() : Sprite
      {
         return _iconSprite;
      }
   }
}

