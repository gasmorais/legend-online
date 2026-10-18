package yishi.scene
{
   public interface ISceneCreate
   {
      
      function create(param1:String) : BaseSceneView;
      
      function createAsync(param1:String, param2:Function) : void;
   }
}

