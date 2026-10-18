package ylex.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import yishi.view.community.BaseIconView;
   
   public class YLExpeditionChooseView extends Sprite
   {
      
      public var _bigBg:Bitmap;
      
      public var _zzNodeHbox:VBox;
      
      public var _zzNodeTitleDes:FilterFrameText;
      
      private var _iconBg:Image;
      
      public var _icon:BaseIconView;
      
      public function YLExpeditionChooseView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bigBg = ComponentFactory.Instance.creatBitmap("asset.ylexdition.zz.bigBg");
         _zzNodeHbox = ComponentFactory.Instance.creatCustomObject("ui.ylexpedition.zzNodeVbox");
         _zzNodeTitleDes = ComponentFactory.Instance.creatComponentByStylename("ui.ylexpedition.zzNodeTitleDes");
         _iconBg = ComponentFactory.Instance.creatComponentByStylename("ui.ylexdition.yd.chooseHeadBg");
         _icon = ComponentFactory.Instance.creatCustomObject("ui.ylexpidtionyd.zjheadIcon");
         addChild(_bigBg);
         addChild(_zzNodeHbox);
         addChild(_zzNodeTitleDes);
         addChild(_iconBg);
         addChild(_icon);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bigBg);
         _bigBg = null;
         ObjectUtils.disposeObject(_zzNodeHbox);
         _zzNodeHbox = null;
         ObjectUtils.disposeObject(_zzNodeTitleDes);
         _zzNodeTitleDes = null;
         ObjectUtils.disposeObject(_iconBg);
         _iconBg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

