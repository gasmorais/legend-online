package yishi.view.community
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import manager.LanguageMgr;
   
   public class HeroCell extends BaseHeroCell
   {
      
      public static const P_nameStyle:String = "nameStyle";
      
      public static const P_levelStyle:String = "levelStyle";
      
      private var _nameStyle:String;
      
      private var _levelStyle:String;
      
      protected var _name:FilterFrameText;
      
      protected var _level:FilterFrameText;
      
      public function HeroCell(param1:Function = null)
      {
         super(param1);
      }
      
      public function set nameStyle(param1:String) : void
      {
         _nameStyle = param1;
         onPropertiesChanged("nameStyle");
      }
      
      public function set levelStyle(param1:String) : void
      {
         _levelStyle = param1;
         onPropertiesChanged("levelStyle");
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["nameStyle"])
         {
            _name = ComponentFactory.Instance.creatComponentByStylename(_nameStyle);
         }
         if(_changedPropeties["levelStyle"])
         {
            _level = ComponentFactory.Instance.creatComponentByStylename(_levelStyle);
         }
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_name)
         {
            addChild(_name);
         }
         if(_level)
         {
            addChild(_level);
         }
      }
      
      protected function clean() : void
      {
         if(_name)
         {
            _name.text = "";
         }
         if(_level)
         {
            _level.text = "";
         }
      }
      
      override protected function refreshView() : void
      {
         var _loc1_:int = 0;
         clean();
         if(!data)
         {
            return;
         }
         super.refreshView();
         if(_name)
         {
            _name.text = data.nickName;
            if(_name.text.length > 8)
            {
               _name.text = _name.text.substr(0,8) + "..";
            }
            if(_level)
            {
               _level.text = LanguageMgr.GetTranslation("public.level2",data.grades);
            }
            _loc1_ = _name.textWidth + _level.textWidth + 2;
            _name.x = (iconX + iconWidth - _loc1_) / 2;
            _level.x = _name.x + _name.textWidth + 2;
         }
      }
   }
}

