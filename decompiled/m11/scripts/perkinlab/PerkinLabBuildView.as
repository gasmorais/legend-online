package perkinlab
{
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import events.PerkinLabEvent;
   import managers.PerkinLabManager;
   import mvc.module.perkinlab.PerkinLabKengInfo;
   import mvc.module.perkinlab.PerkinLabModel;
   
   public class PerkinLabBuildView extends Component
   {
      
      private var itemList:Vector.<PerkinLabKengView>;
      
      public function PerkinLabBuildView()
      {
         super();
         itemList = new Vector.<PerkinLabKengView>();
         initView();
         addEvent();
         PerkinLabManager.instance.sendLabOperate(0);
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:PerkinLabKengView = null;
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = new PerkinLabKengView(0);
            _loc1_.x = model.kengPosArr[_loc2_][0];
            _loc1_.y = model.kengPosArr[_loc2_][1];
            addChild(_loc1_);
            itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         PerkinLabManager.instance.addEventListener("UPDATE_SELF_LIST",__updateBuildView);
      }
      
      private function __updateBuildView(param1:PerkinLabEvent) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:PerkinLabKengInfo = null;
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc2_ = model.getKengInfoByIndexFromList(_loc1_,model.selfKengList);
            itemList[_loc1_].data = _loc2_;
            _loc1_++;
         }
      }
      
      private function get model() : PerkinLabModel
      {
         return PerkinLabManager.instance.model;
      }
      
      private function removeEvent() : void
      {
         PerkinLabManager.instance.removeEventListener("UPDATE_SELF_LIST",__updateBuildView);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(itemList)
         {
            for(var _loc1_:String in itemList)
            {
               ObjectUtils.disposeObject(itemList[_loc1_]);
               itemList[_loc1_] = null;
            }
            itemList = null;
         }
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

