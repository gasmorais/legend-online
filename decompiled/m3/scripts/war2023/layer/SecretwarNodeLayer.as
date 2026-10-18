package war2023.layer
{
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import mvc.module.war2023.SecretWarModel;
   import mvc.module.war2023.info.SecretWarNodeInfo;
   import war2023.item.SecretWarNodeItem;
   import yishi.manager.SecretWarManager;
   
   public class SecretwarNodeLayer extends Sprite
   {
      
      private var _nodeDic:Dictionary = new Dictionary();
      
      public function SecretwarNodeLayer()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         var _loc1_:SecretWarNodeItem = null;
         var _loc2_:Dictionary = model.nodeInfos;
         for each(var _loc3_:SecretWarNodeInfo in _loc2_)
         {
            _loc1_ = new SecretWarNodeItem();
            _loc1_.data = _loc3_;
            addChild(_loc1_);
            _nodeDic[_loc3_.nodeId] = _loc1_;
         }
      }
      
      public function enterFrame() : void
      {
         for each(var _loc1_:SecretWarNodeItem in _nodeDic)
         {
            _loc1_.enterFrame();
         }
      }
      
      private function get model() : SecretWarModel
      {
         return SecretWarManager.Instance.model;
      }
      
      public function dispose() : void
      {
         for each(var _loc1_:SecretWarNodeItem in _nodeDic)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _nodeDic = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

