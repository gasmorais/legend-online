package friends.findfriend
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class FindFriendView extends Sprite implements Disposeable
   {
      
      private var _exactFindView:ExactFindFriendView;
      
      public function FindFriendView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _exactFindView = ComponentFactory.Instance.creatCustomObject("friends.ExactFindFriendView");
         addChild(_exactFindView);
      }
      
      public function dispose() : void
      {
         if(_exactFindView)
         {
            _exactFindView.dispose();
         }
         _exactFindView = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

