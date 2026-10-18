package funny.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import funny.datas.FunnyData;
   import managers.GodDessManager;
   
   public class GoddessDoubleForgeActivityView extends Sprite implements Disposeable
   {
      
      private var _back:Bitmap;
      
      private var _time:FilterFrameText;
      
      public function GoddessDoubleForgeActivityView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.funny.goddessDoubleForgeBg");
         _time = ComponentFactory.Instance.creatComponentByStylename("funny.goddessTime");
         addChild(_back);
         addChild(_time);
         _time.text = GodDessManager.instance.model.doubleOpenString + " - " + GodDessManager.instance.model.doubleEndString;
      }
      
      public function set data(param1:FunnyData) : void
      {
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

