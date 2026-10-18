package battle.view.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class BossBottomStrip extends BossStripUIView
   {
      
      public function BossBottomStrip(param1:int, param2:Number = 0, param3:uint = 0, param4:Boolean = true)
      {
         super(param1,param2,param3,param4);
      }
      
      override protected function initView(param1:String, param2:String) : void
      {
         if(_stripNum > 1)
         {
            _viewStyleName = "asset.battle.BossBottomStripAsset";
            _underStripView = new StripUIView(MovieClip(ComponentFactory.Instance.creat(_viewStyleName)),0,0,16275472);
            _underStripView.asset.upStrip.gotoAndStop(_stripNum - 1);
            this.addChild(_underStripView.getView());
            _currentStripNumView = new Sprite();
            setStripNumViewByIndex(_stripNum);
         }
         _upStripView = new StripUIView(MovieClip(ComponentFactory.Instance.creat(_viewStyleName)),0,0,16275472,true,false,null);
         _upStripView.asset.upStrip.gotoAndStop(_stripNum);
         this.addChild(_upStripView.getView());
      }
      
      override protected function setStripNumViewByIndex(param1:int) : void
      {
      }
      
      public function resetView() : void
      {
         _currentStripIndex = _stripNum;
         if(_stripNum > 1 && !_underStripView)
         {
            _underStripView = new StripUIView(MovieClip(ComponentFactory.Instance.creat(_viewStyleName)),0,0,16275472);
            _underStripView.asset.upStrip.gotoAndStop(_stripNum - 1);
            this.addChild(_underStripView.getView());
            _currentStripNumView = new Sprite();
            setStripNumViewByIndex(_stripNum);
         }
         _upStripView.asset.upStrip.gotoAndStop(_stripNum);
         this.addChild(_upStripView.getView());
         if(_currentStripNumView)
         {
            _currentStripNumView.scaleX = _scaleX;
            if(_scaleX < 0)
            {
               _currentStripNumView.x = 400;
            }
            else
            {
               _currentStripNumView.x = 350;
            }
            _currentStripNumView.y = -13;
            this.addChild(_currentStripNumView);
         }
      }
   }
}

