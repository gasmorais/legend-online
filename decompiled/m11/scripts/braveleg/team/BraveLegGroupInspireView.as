package braveleg.team
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   
   public class BraveLegGroupInspireView extends Component
   {
      
      private static const GroupNum:int = 3;
      
      private var _inspireList:ListPanel;
      
      public function BraveLegGroupInspireView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         _inspireList = ComponentFactory.Instance.creatComponentByStylename("braveleg.InspireList");
         addChild(_inspireList);
         _inspireList.beginChanges();
         _inspireList.vectorListModel.clear();
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _inspireList.vectorListModel.append({
               "groupId":_loc1_ + 1,
               "id":0,
               "grades":0
            });
            _loc1_++;
         }
         _inspireList.commitChanges();
         _inspireList.list.updateListView();
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_inspireList);
         _inspireList = null;
         super.dispose();
      }
      
      public function set data(param1:Object) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _inspireList.beginChanges();
         _inspireList.vectorListModel.clear();
         _loc3_ = 0;
         while(_loc3_ < 3)
         {
            _loc2_ = _loc3_ + 1;
            _inspireList.vectorListModel.append({
               "groupId":_loc2_,
               "isReady":param1.isReady,
               "count":param1.count,
               "masterType":param1["data"]["groupType" + _loc2_],
               "grades":param1["data"]["groupGrade" + _loc2_]
            });
            _loc3_++;
         }
         _inspireList.commitChanges();
         _inspireList.list.updateListView();
      }
   }
}

