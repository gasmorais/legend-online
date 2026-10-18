package buildings.politics.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   
   public class FildTitleItem extends Sprite implements Disposeable
   {
      
      private var _background:ScaleLeftRightImage;
      
      private var _nameText:FilterFrameText;
      
      private var _posText:FilterFrameText;
      
      private var _yieldText:FilterFrameText;
      
      private var _timeText:FilterFrameText;
      
      private var _opText:FilterFrameText;
      
      public function FildTitleItem()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _background = ComponentFactory.Instance.creatComponentByStylename("politics.TitleBack");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("politics.FieldNameText");
         _nameText.text = LanguageMgr.GetTranslation("buildings.politics.view.name");
         _posText = ComponentFactory.Instance.creatComponentByStylename("politics.FieldPosText");
         _posText.text = LanguageMgr.GetTranslation("buildings.politics.view.pos");
         _yieldText = ComponentFactory.Instance.creatComponentByStylename("politics.FieldYieldText");
         _yieldText.text = LanguageMgr.GetTranslation("buildings.politics.view.yield");
         _timeText = ComponentFactory.Instance.creatComponentByStylename("politics.FieldTimeText");
         _timeText.text = LanguageMgr.GetTranslation("buildings.politics.view.time");
         _opText = ComponentFactory.Instance.creatComponentByStylename("politics.FieldOPText");
         _opText.text = LanguageMgr.GetTranslation("buildings.politics.view.op");
         addChild(_background);
         addChild(_nameText);
         addChild(_posText);
         addChild(_yieldText);
         addChild(_timeText);
         addChild(_opText);
      }
      
      private function uninit() : void
      {
         _background = null;
         _nameText = null;
         _posText = null;
         _yieldText = null;
         _timeText = null;
         _opText = null;
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      public function dispose() : void
      {
         uninit();
      }
   }
}

