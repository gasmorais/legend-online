package artifact
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import managers.VIPManager;
   import mvc.module.vip.VIPModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.NotificationManager;
   import yishi.view.community.BaseItemView;
   
   public class ArtifactBoxItem extends Component
   {
      
      private var _maskContainer:DisplayObjectContainer;
      
      private var _boxItem:BaseItemView;
      
      private var _selectBg:Bitmap;
      
      private var _index:int;
      
      private var _countTxt:FilterFrameText;
      
      private var _selected:Boolean;
      
      private var _delayTime:Number;
      
      private var _movieImg:MovieImage;
      
      private var _flickerEffct:MovieClip;
      
      public function ArtifactBoxItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _maskContainer = getBackContainer();
         _boxItem = ComponentFactory.Instance.creatCustomObject("artifact.shopItem");
         _selectBg = ComponentFactory.Instance.creatBitmap("asset.artifact.vipBoxItemSelect");
         _flickerEffct = ComponentFactory.Instance.creatCustomObject("artifact.goodsFlickerEffctMC");
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("artifact.VipBoxItemCountTxt");
         _movieImg = ComponentFactory.Instance.creatComponentByStylename("artifact.altarGoodsEffctMC");
         addChild(_maskContainer);
         _maskContainer.addChild(_boxItem);
         addChild(_countTxt);
         addChild(_selectBg);
         addChild(_flickerEffct);
         _selectBg.visible = false;
         _flickerEffct.visible = false;
         _flickerEffct.gotoAndStop(1);
         _flickerEffct.mouseChildren = _flickerEffct.mouseEnabled = false;
         _countTxt.mouseEnabled = false;
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
      
      private function getBackContainer() : Sprite
      {
         return ClassUtils.CreatInstance("asset.artifact.BaseBoxContainer") as Sprite;
      }
      
      public function set Index(param1:int) : void
      {
         _index = param1;
      }
      
      public function get Index() : int
      {
         return _index;
      }
      
      public function set count(param1:int) : void
      {
         var _loc2_:String = null;
         if(param1 > 1)
         {
            if(param1 >= 1000000)
            {
               _loc2_ = (param1 / 1000000).toFixed(1) + LanguageMgr.GetTranslation("public.Million");
            }
            else if(param1 > 999000 && param1 < 1000000)
            {
               _loc2_ = "1.0" + LanguageMgr.GetTranslation("public.Million");
            }
            else if(param1 >= 10000 && param1 <= 999000)
            {
               _loc2_ = Math.round(param1 / 1000) + LanguageMgr.GetTranslation("public.Thousands");
            }
            else
            {
               _loc2_ = param1 + "";
            }
            _countTxt.text = _loc2_.toString();
         }
      }
      
      public function set data(param1:GoodsInfo) : void
      {
         _boxItem.data = param1;
      }
      
      public function get templeteId() : int
      {
         if(!_boxItem.data)
         {
            return 0;
         }
         return _boxItem.data.templateId;
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
         ObjectUtils.disposeObject(_boxItem);
         _boxItem = null;
         ObjectUtils.disposeObject(_selectBg);
         _selectBg = null;
         ObjectUtils.disposeObject(_countTxt);
         _countTxt = null;
         ObjectUtils.disposeObject(_movieImg);
         _movieImg = null;
         ObjectUtils.disposeViolentMc(_flickerEffct);
         _flickerEffct = null;
         ObjectUtils.disposeObject(_maskContainer);
         _maskContainer = null;
         super.dispose();
      }
   }
}

