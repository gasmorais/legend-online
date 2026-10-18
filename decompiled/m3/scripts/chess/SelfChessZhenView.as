package chess
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class SelfChessZhenView extends Sprite
   {
      
      public var _tip2DesTxt:FilterFrameText;
      
      public var _tip2Title1:FilterFrameText;
      
      public var _tip2Title2:FilterFrameText;
      
      public function SelfChessZhenView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _tip2DesTxt = ComponentFactory.Instance.creatComponentByStylename("ui.selfchess.tip2DesTxt");
         _tip2Title1 = ComponentFactory.Instance.creatComponentByStylename("ui.selfchess.tip2Title1");
         _tip2Title2 = ComponentFactory.Instance.creatComponentByStylename("ui.selfchess.tip2Title2");
         addChild(_tip2DesTxt);
         addChild(_tip2Title1);
         addChild(_tip2Title2);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_tip2DesTxt);
         _tip2DesTxt = null;
         ObjectUtils.disposeObject(_tip2Title1);
         _tip2Title1 = null;
         ObjectUtils.disposeObject(_tip2Title2);
         _tip2Title2 = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

