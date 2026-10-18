package armyII.viewII.dragonsoul
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   import yishi.view.tools.SimpleBitmapMovieClip;
   
   public class DragonSoulExpView
   {
      
      private var _container:Sprite;
      
      private var _expPool:DragonSoulBallComp;
      
      private var _alphaBall:Bitmap;
      
      private var _topBall2:Bitmap;
      
      private var _topBall3:Bitmap;
      
      private var _expTxt:FilterFrameText;
      
      public function DragonSoulExpView(param1:Sprite)
      {
         super();
         _container = param1;
         initView();
      }
      
      private function initView() : void
      {
         var _loc2_:MovieClip = ComponentFactory.Instance.creat("asset.dragonsoul.ExpPoolLineMC");
         _loc2_.alpha = 0.6;
         var _loc1_:ColorTransform = new ColorTransform(0.7,0,0);
         _loc2_.transform.colorTransform = _loc1_;
         _expPool = new DragonSoulBallComp(1,0,_loc2_);
         _container.addChildAt(_expPool.getView(),4);
         _alphaBall = ComponentFactory.Instance.creatBitmap("asset.dragonsoul.ExpAlphaBall");
         _topBall2 = ComponentFactory.Instance.creatBitmap("asset.dragonsoul.ExpTopBall2");
         _topBall3 = ComponentFactory.Instance.creatBitmap("asset.dragonsoul.ExpTopBall3");
         _expTxt = ComponentFactory.Instance.creatComponentByStylename("armyII.SoulView.ExpTxt");
         _expPool.getView().addChild(_alphaBall);
         _expPool.getView().addChild(_topBall2);
         _expPool.getView().addChild(_topBall3);
         _expPool.getView().addChild(_expTxt);
         _topBall2.visible = false;
         _topBall3.visible = false;
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_alphaBall);
         _alphaBall = null;
         ObjectUtils.disposeObject(_topBall2);
         _topBall2 = null;
         ObjectUtils.disposeObject(_topBall3);
         _topBall3 = null;
         ObjectUtils.disposeObject(_expTxt);
         _expTxt = null;
         if(_expPool)
         {
            if(_expPool.getView() && _expPool.getView().parent)
            {
               _expPool.getView().parent.removeChild(_expPool.getView());
            }
            _expPool.dispose();
            _expPool = null;
         }
      }
      
      public function setTopBall(param1:int) : void
      {
         if(_expPool)
         {
            if(param1 == 1)
            {
               _topBall2.visible = false;
               _topBall3.visible = false;
            }
            else if(param1 == 2)
            {
               _topBall2.visible = true;
               _topBall3.visible = false;
            }
            else if(param1 == 3)
            {
               _topBall2.visible = false;
               _topBall3.visible = true;
            }
         }
      }
      
      public function setPosition(param1:Number, param2:Number) : void
      {
         if(_expPool)
         {
            _expPool.getView().x = param1;
            _expPool.getView().y = param2;
         }
      }
      
      public function setVisible(param1:Boolean) : void
      {
         if(_expPool)
         {
            _expPool.getView().visible = param1;
         }
      }
      
      public function setRotation(param1:Boolean) : void
      {
         if(_expPool)
         {
            _expPool.setRotation(param1);
         }
      }
      
      public function showBall(param1:Boolean) : void
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:SimpleBitmapMovieClip = null;
         if(_expPool)
         {
            _loc2_ = ComponentFactory.Instance.creat("asset.dragonsoul.ExplPoolBallMC");
            _loc3_ = new SimpleBitmapMovieClip(MovieClip(_loc2_),"asset.dragonsoul.ExplPoolBallMC");
            _expPool.showBall(_loc3_,param1);
         }
      }
      
      public function updateExp(param1:int, param2:int, param3:Boolean = false) : void
      {
         if(_expPool)
         {
            _expPool.max = param2;
            if(param3)
            {
               _expPool.updateTo(param1);
            }
            else
            {
               _expPool.update(param1);
            }
            _expTxt.text = param1 + " / " + param2;
         }
      }
      
      public function reset(param1:Boolean = false) : void
      {
         if(_expPool)
         {
            _expPool.max = 1;
            if(param1)
            {
               _expPool.updateTo(1);
            }
            else
            {
               _expPool.update(1);
            }
            _expTxt.text = "";
         }
      }
      
      public function dispose() : void
      {
         uninitView();
      }
   }
}

