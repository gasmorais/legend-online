package armyII.viewII.stone.item
{
   import com.greensock.TweenMax;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import yishi.datas.goods.GoodsInfo;
   import yishi.view.community.BaseItemView;
   
   public class StoneCardItem extends Sprite implements IManualSize
   {
      
      private var _mc:MovieClip;
      
      private var _one:BaseItemView;
      
      private var _bg:Bitmap;
      
      private var _info:GoodsInfo;
      
      private var _tMax:TweenMax;
      
      public function StoneCardItem()
      {
         super();
         initView();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,90,90);
      }
      
      private function initView() : void
      {
         _mc = ComponentFactory.Instance.creatCustomObject("asset.army.stoneItemEff");
         _one = ComponentFactory.Instance.creatCustomObject("feedBackFrame.BaseItemView");
         _bg = ComponentFactory.Instance.creatBitmap("asset.core2.boxBg");
         addChild(_mc);
         _bg.x = -1;
         _bg.y = -1;
         _bg.width = 55;
         _bg.height = 55;
         _mc["mc_pef"].mouseEnabled = false;
         _mc["mc_pef"].mouseChildren = false;
         _mc.gotoAndStop(_mc.totalFrames - 1);
         _mc.addFrameScript(_mc.totalFrames - 1,playEndHandler);
      }
      
      public function updateView(param1:GoodsInfo, param2:Number) : void
      {
         _info = param1;
         _tMax = TweenMax.delayedCall(param2,onComplete);
      }
      
      private function onComplete() : void
      {
         _mc.gotoAndPlay(1);
      }
      
      private function playEndHandler() : void
      {
         var _loc1_:MovieClip = null;
         _one.data = _info;
         if(_info)
         {
            _loc1_ = _mc["mc_pef"];
            if(_info.templateInfo.Profile == 4)
            {
               _loc1_.gotoAndStop(3);
            }
            else if(_info.templateInfo.Profile == 5)
            {
               _loc1_.gotoAndStop(2);
            }
         }
         _mc["mc_content"].addChild(_bg);
         _mc["mc_content"].addChild(_one);
         _mc.stop();
      }
      
      public function dispose() : void
      {
         if(_mc)
         {
            _mc.addFrameScript(_mc.totalFrames - 1,null);
         }
         if(_tMax)
         {
            _tMax.kill();
         }
         _tMax = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeViolentMc(_mc);
         _mc = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _info = null;
      }
   }
}

