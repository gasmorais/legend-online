package chargelottery
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import managers.VIPManager;
   import mvc.module.vip.VIPModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.NotificationManager;
   import yishi.view.community.BaseItemView;
   
   public class ChargeLotteryItem extends Component
   {
      
      private var _specialItem:Bitmap;
      
      private var _boxItem:BaseItemView;
      
      private var _selectBg:Bitmap;
      
      private var _index:int;
      
      private var _templateType:int;
      
      private var _pos:int;
      
      private var _data:GoodsInfo;
      
      private var _selected:Boolean;
      
      private var _delayTime:Number;
      
      private var _movieImg:MovieImage;
      
      private var _flickerEffct:MovieClip;
      
      public function ChargeLotteryItem(param1:int)
      {
         super();
         _index = param1;
         initView();
      }
      
      private function initView() : void
      {
         _specialItem = ComponentFactory.Instance.creatBitmap("asset.chargelottery.specialItem");
         _boxItem = ComponentFactory.Instance.creatCustomObject("chargelottery.shopItem");
         _movieImg = ComponentFactory.Instance.creatComponentByStylename("chargelottery.altarGoodsEffctMC");
         if(_index == 6 || _index == 17)
         {
            _selectBg = ComponentFactory.Instance.creatBitmap("asset.chargelottery.vipBoxItemSelect2");
            _flickerEffct = ComponentFactory.Instance.creatCustomObject("chargelottery.goodsFlickerEffctMC2");
            _movieImg.x = 40;
            _movieImg.y = 35;
            _boxItem.visible = false;
         }
         else
         {
            _selectBg = ComponentFactory.Instance.creatBitmap("asset.chargelottery.vipBoxItemSelect");
            _flickerEffct = ComponentFactory.Instance.creatCustomObject("chargelottery.goodsFlickerEffctMC");
            _movieImg.x = 23;
            _movieImg.y = 23;
            _specialItem.visible = false;
         }
         addChild(_selectBg);
         addChild(_flickerEffct);
         addChild(_specialItem);
         addChild(_boxItem);
         _selectBg.visible = false;
         _flickerEffct.visible = false;
         _flickerEffct.gotoAndStop(1);
         _flickerEffct.mouseChildren = _flickerEffct.mouseEnabled = false;
         _movieImg.mouseChildren = _movieImg.mouseEnabled = false;
         _movieImg.movie.addFrameScript(_movieImg.movie.totalFrames - 1,onFrameEnd);
         _movieImg.movie.gotoAndStop(1);
      }
      
      private function onFrameEnd() : void
      {
         _movieImg.movie.stop();
         _movieImg.movie.gotoAndStop(1);
         NotificationManager.instance.sendNotification("ARTIFACT_BOX_FLICHER");
      }
      
      public function set data(param1:GoodsInfo) : void
      {
         if(!_data)
         {
            _data = param1;
            if(_data.templateId != 0)
            {
               _boxItem.data = param1;
            }
         }
      }
      
      public function set templateType(param1:int) : void
      {
         _templateType = param1;
      }
      
      public function set pos(param1:int) : void
      {
         _pos = param1;
      }
      
      public function get pos() : int
      {
         return _pos;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         _delayTime = model.delayTime * 0.002;
         if(_selected)
         {
            _selectBg.alpha = 1;
            _selectBg.visible = true;
            _delayTime = model.delayTime > 400 ? 0.8 : model.delayTime * 0.002;
            if(_delayTime)
            {
               setTween();
            }
         }
         else if(!_delayTime)
         {
            _selectBg.visible = false;
         }
      }
      
      public function flicker() : void
      {
         if(!_movieImg.parent)
         {
            addChild(_movieImg);
         }
         _movieImg.movie.play();
         _flickerEffct.visible = true;
         _flickerEffct.gotoAndPlay(1);
      }
      
      public function clearFlicker() : void
      {
         _flickerEffct.visible = false;
         _flickerEffct.gotoAndStop(1);
      }
      
      private function setTween() : void
      {
         TweenLite.killTweensOf(_selectBg);
         _selectBg.alpha = 0;
         var _loc1_:Number = _delayTime;
         if(_delayTime >= 0.6)
         {
            _loc1_ = 0.3;
         }
         if(_delayTime >= 0.8)
         {
            _loc1_ = 0.05;
         }
         TweenLite.to(_selectBg,_loc1_ + 0.2,{
            "alpha":1,
            "onComplete":hideBg
         });
      }
      
      private function hideBg() : void
      {
         TweenLite.killTweensOf(_selectBg);
         hideMoveBg(_delayTime);
      }
      
      public function hideMoveBg(param1:Number) : void
      {
         TweenLite.to(_selectBg,param1,{
            "alpha":0,
            "onComplete":removeHideMoveBgTween
         });
      }
      
      private function removeHideMoveBgTween() : void
      {
         TweenLite.killTweensOf(_selectBg);
      }
      
      private function get model() : VIPModel
      {
         return VIPManager.Instance.model;
      }
      
      override public function dispose() : void
      {
         _movieImg.movie.addFrameScript(_movieImg.movie.totalFrames - 1,null);
         TweenLite.killTweensOf(_selectBg);
         ObjectUtils.disposeObject(_specialItem);
         _specialItem = null;
         ObjectUtils.disposeObject(_boxItem);
         _boxItem = null;
         ObjectUtils.disposeObject(_selectBg);
         _selectBg = null;
         ObjectUtils.disposeObject(_movieImg);
         _movieImg = null;
         ObjectUtils.disposeViolentMc(_flickerEffct);
         _flickerEffct = null;
         _data = null;
         super.dispose();
      }
   }
}

