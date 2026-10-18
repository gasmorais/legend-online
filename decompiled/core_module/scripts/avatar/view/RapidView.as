package avatar.view
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import yishi.manager.PathManager;
   
   public class RapidView extends Component
   {
      
      private var icon:Bitmap;
      
      private var _url:String;
      
      private var _iconWidth:Number = 60;
      
      private var _iconHeight:Number = 56;
      
      private var _colorTxt:FilterFrameText;
      
      public function RapidView()
      {
         super();
         this.width = 60;
         this.height = 56;
         _colorTxt = ComponentFactory.Instance.creatComponentByStylename("RapidView.colorTxt");
         addChild(_colorTxt);
         _colorTxt.text = "";
      }
      
      public function refreshView(param1:int, param2:int) : void
      {
         _colorTxt.text = LanguageMgr.GetTranslation("RapidView.colorTxt" + param2);
         _url = PathManager.getRapidViewIcon(param2,param1);
         var _loc3_:int = 5;
         if(LoaderManagerII.instance.isLoaded(_url))
         {
            _loc3_ = 0;
         }
         LoaderManagerII.instance.load(_url,2,_loc3_,loadCompleteHandler);
      }
      
      override public function dispose() : void
      {
         if(icon)
         {
            if(this.contains(icon))
            {
               this.removeChild(icon);
            }
            icon.bitmapData.dispose();
            icon = null;
         }
      }
      
      private function loadCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         if(icon && this.contains(icon))
         {
            this.removeChild(icon);
            icon.bitmapData.dispose();
            icon = null;
         }
         if(param2 is Bitmap)
         {
            icon = param2 as Bitmap;
            this.addChild(icon);
         }
      }
      
      override public function get width() : Number
      {
         return _iconWidth;
      }
      
      override public function get height() : Number
      {
         return _iconHeight;
      }
   }
}

