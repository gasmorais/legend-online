package revenge.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class RevengeNodeView extends Sprite
   {
      
      public var _bossBtn:BaseButton;
      
      public var _linesBg:MovieClip;
      
      public var _bossBg:Bitmap;
      
      public var _title2:Bitmap;
      
      public var _2bg:Bitmap;
      
      public var _hbox:HBox;
      
      public function RevengeNodeView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bossBtn = ComponentFactory.Instance.creatComponentByStylename("ui.revengeroad.bossBtn");
         _linesBg = ComponentFactory.Instance.creatCustomObject("asset.revengeroad.linesBg");
         _bossBg = ComponentFactory.Instance.creatBitmap("asset.revengeroad.bossBg");
         _title2 = ComponentFactory.Instance.creatBitmap("asset.revengeroad.bossMore");
         _2bg = ComponentFactory.Instance.creatBitmap("asset.revengeroad.2bg");
         _hbox = ComponentFactory.Instance.creatCustomObject("ui.revengeroad.bossRewardHbox");
         addChild(_2bg);
         addChild(_linesBg);
         addChild(_bossBg);
         addChild(_bossBtn);
         addChild(_title2);
         addChild(_hbox);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bossBtn);
         _bossBtn = null;
         ObjectUtils.disposeViolentMc(_linesBg);
         _linesBg = null;
         ObjectUtils.disposeObject(_bossBg);
         _bossBg = null;
         ObjectUtils.disposeObject(_title2);
         _title2 = null;
         ObjectUtils.disposeObject(_2bg);
         _2bg = null;
         ObjectUtils.disposeObject(_hbox);
         _hbox = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

