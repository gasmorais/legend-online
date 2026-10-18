package consortia.view.myConsortia.chairmanElection
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   
   public class ElectionListTitle extends Sprite implements Disposeable
   {
      
      private var _bg:MutipleImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _numTxt:FilterFrameText;
      
      public function ElectionListTitle()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("consortia.ElectionTitleBackStyle");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ElectionItemNameTitleTxt");
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ElectionItemNumTitleTxt");
         _nameTxt.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanElection.title1");
         _numTxt.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanElection.title2");
         addChild(_bg);
         addChild(_nameTxt);
         addChild(_numTxt);
      }
      
      public function dispose() : void
      {
         _bg = null;
         _nameTxt = null;
         _numTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

