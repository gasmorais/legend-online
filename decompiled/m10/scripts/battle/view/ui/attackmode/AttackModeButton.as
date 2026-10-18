package battle.view.ui.attackmode
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.DisplayObject;
   import manager.LanguageMgr;
   
   public class AttackModeButton extends BaseButton
   {
      
      private var _selected:Boolean;
      
      private var _selectedView:DisplayObject;
      
      private var _nameTf:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("battle.ModeNameTxt");
      
      private var _keyTf:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("battle.ValidTimeTxt");
      
      private var _modeName:String;
      
      private var _turnTf:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("battle.TurnNumTxt");
      
      private var _turnStrTf:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("battle.TurnStrTxt");
      
      public function AttackModeButton()
      {
         super();
      }
      
      public function setKeyValue(param1:String) : void
      {
         _keyTf.text = param1;
      }
      
      public function set modeName(param1:String) : void
      {
         _modeName = param1;
         _nameTf.text = _modeName;
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(_selected == param1)
         {
            return;
         }
         _selected = param1;
         Object(_back).selectedMC.visible = _selected;
         _turnTf.visible = _turnStrTf.visible = _selected;
         _nameTf.visible = !_selected;
      }
      
      public function setTurnValue(param1:int) : void
      {
         _turnTf.text = param1 + "";
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_back)
         {
            Object(_back).selectedMC.visible = false;
         }
         addChild(_nameTf);
         addChild(_keyTf);
         addChild(_turnTf);
         addChild(_turnStrTf);
         _turnTf.visible = _turnStrTf.visible = false;
         _turnStrTf.text = LanguageMgr.GetTranslation("battle.view.ui.attackmode.turnStrTf.text");
      }
   }
}

