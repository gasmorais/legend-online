package mvc.controler
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentSetting;
   import mvc.FrameController;
   
   public class ArtifactControler extends FrameController
   {
      
      private var _needUpdate:Boolean = true;
      
      public var artifactOpen:Boolean;
      
      public function ArtifactControler()
      {
         super();
      }
      
      override protected function get preLoad() : Boolean
      {
         if(_needUpdate)
         {
            return true;
         }
         return false;
      }
      
      override protected function startPreLoad() : void
      {
         var _loc1_:String = ComponentSetting.getProjectSourcePath("15.png");
         LoaderManagerII.instance.load(_loc1_,3,0,__completeHandler);
      }
      
      private function __completeHandler(param1:LoaderInfo, param2:Object) : void
      {
         _needUpdate = false;
         super.start(_data);
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
      }
      
      override public function get frameClassName() : String
      {
         return "artifact.ArtifactFrame";
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
      }
   }
}

