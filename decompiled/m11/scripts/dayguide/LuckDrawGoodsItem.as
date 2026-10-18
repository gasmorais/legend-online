package dayguide
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.vip.VipItemInfoMsg;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import mvc.module.consortia.ConsortiaModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class LuckDrawGoodsItem extends Sprite implements Disposeable, ISelectable
   {
      
      private var _selected:Boolean;
      
      private var _data:GoodsTemplateInfo;
      
      private var _icon:BaseItemView;
      
      private var _profileBg:ScaleFrameImage;
      
      private var _moveBg:Bitmap;
      
      private var _mask:MovieClip;
      
      private var _flicker:MovieClip;
      
      private var _delayTime:Number;
      
      private var _iconSprite:Sprite;
      
      private var _iconIndex:int;
      
      private var _getMovie:MovieClip;
      
      public function LuckDrawGoodsItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _moveBg = ComponentFactory.Instance.creatBitmap("asset.dayGuide.altarMoveBg");
         _profileBg = ComponentFactory.Instance.creatComponentByStylename("dayGuide.ContributeItemProfileBg");
         _mask = ComponentFactory.Instance.creat("asset.dayGuide.altarGoodsMask");
         _flicker = ComponentFactory.Instance.creat("asset.dayGuide.altarGoodsFlickerEffctMC");
         _moveBg.visible = false;
         _profileBg.setFrame(1);
         _mask.x = 21;
         _mask.y = 21;
         _iconSprite = new Sprite();
         _icon = ComponentFactory.Instance.creatCustomObject("LuckDrawGoodsItem.goodItem");
         setIcon();
         _flicker.x = _moveBg.x + 8;
         _flicker.y = _moveBg.y + 5;
         _flicker.gotoAndStop(1);
         _flicker.visible = false;
         addChild(_profileBg);
         addChild(_moveBg);
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
      
      public function get data() : GoodsTemplateInfo
      {
         return _data;
      }
      
      public function set data1(param1:VipItemInfoMsg) : void
      {
         var _loc2_:GoodsInfo = null;
         _data = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1.tempId);
         resetIconSprite();
         if(_data)
         {
            _loc2_ = new GoodsInfo();
            _loc2_.templateId = param1.tempId;
            _loc2_.count = param1.count;
            _icon.data = _loc2_;
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
         _getMovie = ComponentFactory.Instance.creatCustomObject("dayGuide.GetGoodsMovie");
         addChild(_getMovie);
         _getMovie.play();
         _getMovie.addFrameScript(_getMovie.totalFrames - 1,__dispatchEvt);
      }
      
      private function __dispatchEvt() : void
      {
         _getMovie.stop();
         removeChild(_getMovie);
         _getMovie = null;
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

