package ylex.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   
   public class YLExpedtionNodeItem extends Sprite
   {
      
      public var _zzNodeBg:ScaleFrameImage;
      
      public var _zzNodeFlg:ScaleFrameImage;
      
      public var _zzNodeDes:FilterFrameText;
      
      private var _diff:int;
      
      public function YLExpedtionNodeItem()
      {
         super();
         initView();
      }
      
      public function get diff() : int
      {
         return _diff;
      }
      
      public function set diff(param1:int) : void
      {
         _diff = param1;
         _zzNodeFlg.setFrame(_diff);
         _zzNodeDes.text = LanguageMgr.GetTranslation("YLExpeditionItem.choose" + _diff);
      }
      
      private function initView() : void
      {
         _zzNodeBg = ComponentFactory.Instance.creatComponentByStylename("ui.ylexpedition.zzNodeBg");
         _zzNodeFlg = ComponentFactory.Instance.creatComponentByStylename("ui.ylexpedition.zzNodeFlg");
         _zzNodeDes = ComponentFactory.Instance.creatComponentByStylename("ui.ylexpedition.zzNodeDes");
         addChild(_zzNodeBg);
         addChild(_zzNodeFlg);
         addChild(_zzNodeDes);
         _zzNodeBg.setFrame(1);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_zzNodeBg);
         _zzNodeBg = null;
         ObjectUtils.disposeObject(_zzNodeFlg);
         _zzNodeFlg = null;
         ObjectUtils.disposeObject(_zzNodeDes);
         _zzNodeDes = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

