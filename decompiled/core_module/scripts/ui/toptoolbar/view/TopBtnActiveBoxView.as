package ui.toptoolbar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   
   public class TopBtnActiveBoxView extends Component
   {
      
      private var back:ScaleBitmapImage;
      
      private var btnList:SimpleTileList;
      
      public function TopBtnActiveBoxView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatComponentByStylename("TimeActiveBoxView.back");
         btnList = ComponentFactory.Instance.creatCustomObject("topBtn.ActiveBoxView.SimpleTileList",[4]);
         addChild(back);
         addChild(btnList);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,7);
      }
      
      public function refreshView(param1:Array) : void
      {
         var _loc3_:DisplayObject = null;
         var _loc4_:int = 0;
         btnList.disposeAllChildren();
         btnList.beginChanges();
         var _loc2_:int = int(param1 ? param1.length : 0);
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = param1[_loc4_];
            if(_loc3_)
            {
               btnList.addChild(_loc3_);
            }
            _loc4_++;
         }
         btnList.commitChanges();
         back.width = btnList.x + btnList.width + 5;
         back.height = btnList.y + btnList.height + 5;
      }
      
      override public function dispose() : void
      {
         if(btnList)
         {
            btnList.removeAllChild();
         }
         ObjectUtils.disposeObject(back);
         back = null;
         ObjectUtils.disposeObject(btnList);
         btnList = null;
         super.dispose();
      }
   }
}

