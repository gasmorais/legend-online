package consortia.view.myConsortia.chairmanElection
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import flash.display.Sprite;
   
   public class ElectionVoteView extends Sprite implements Disposeable
   {
      
      private var _bg:ScaleLeftRightImage;
      
      private var _voteBtn:IconButton;
      
      public function ElectionVoteView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("consortia.ElectionVoteBg");
         _voteBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.ElectionVotebtn");
         addChild(_bg);
         addChild(_voteBtn);
      }
      
      public function dispose() : void
      {
         _bg = null;
         _voteBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get voteBtn() : IconButton
      {
         return _voteBtn;
      }
   }
}

