package ui.gameroll
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.utils.NumberViewUtils;
   
   public class HeroFightingUpdateView extends Sprite implements Disposeable
   {
      
      private var _bg:MutipleImage;
      
      private var _container:Sprite;
      
      private var _fightBmp:Bitmap;
      
      public function HeroFightingUpdateView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("HeroFightingUpdateView.bg");
         _fightBmp = ComponentFactory.Instance.creatBitmap("asset.fightingup.numberImage");
         _container = new Sprite();
         _container.x = 67;
         _container.y = 23;
         addChild(_bg);
         addChild(_container);
         mouseEnabled = mouseChildren = false;
      }
      
      public function setNumberView(param1:int) : void
      {
         NumberViewUtils.getNumberView(param1,_container,_fightBmp.bitmapData,26,25,19,26,"0123456789",2);
      }
      
      public function show() : void
      {
         this.x = (StageReferance.gameStageWidth - this.width) / 2;
         this.y = StageReferance.gameStageHeight - 200;
         _container.x = (this.width - _container.width) / 2;
         LayerManager.Instance.addToLayer(this,2,false,false);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_fightBmp);
         _fightBmp = null;
         _container = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

