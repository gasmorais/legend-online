package dragontalker.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import yishi.datas.templates.DragonTalkerFightMountTempInfo;
   import yishi.view.component.TileContainer;
   
   public class DragonTalkerBattleBeastPropItem extends Component
   {
      
      private var _titleText:FilterFrameText;
      
      private var _propContiner:TileContainer;
      
      private var _newAvatarText:FilterFrameText;
      
      private var _maxImage:Image;
      
      private var _type:int;
      
      public function DragonTalkerBattleBeastPropItem(param1:int)
      {
         super();
         _type = param1;
         initView();
      }
      
      private function initView() : void
      {
         _titleText = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerBattleBeastPropItem.titleText");
         _propContiner = ComponentFactory.Instance.creatCustomObject("DragonTalkerBattleBeastPropItem.propContiner");
         _newAvatarText = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerBattleBeastPropItem.newAvatarText");
         _maxImage = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerBattleBeastPropItem.maxImage");
         addChild(_titleText);
         addChild(_propContiner);
         addChild(_newAvatarText);
         addChild(_maxImage);
         _maxImage.visible = false;
      }
      
      public function showPropText(param1:DragonTalkerFightMountTempInfo) : void
      {
         var _loc9_:Array = null;
         var _loc4_:int = 0;
         var _loc3_:String = null;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         var _loc2_:int = 0;
         var _loc8_:String = null;
         var _loc5_:FilterFrameText = null;
         ObjectUtils.disposeAllChildren(_propContiner);
         if(!param1)
         {
            _maxImage.visible = true;
            _titleText.text = "";
            _newAvatarText.text = "";
            return;
         }
         _loc9_ = param1.hasValueAtt;
         _loc4_ = int(_loc9_.length);
         if(_type == 1)
         {
            _loc3_ = "<font color=\'#f8c071\'>+" + param1.HitPoint + "</font>";
            _newAvatarText.text = "";
         }
         else
         {
            _loc3_ = "<font color=\'#00e430\'>+" + param1.HitPoint + "</font>";
            _newAvatarText.text = LanguageMgr.GetTranslation("DragonTalkerBattleBeastPropItem.newAvatarText.text");
         }
         _maxImage.visible = false;
         _titleText.htmlText = LanguageMgr.GetTranslation("public.level2",param1.Grade) + " " + LanguageMgr.GetTranslation("DragonTalkerBattleBeastPropItem.titleText.text",_loc3_);
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc7_ = _loc9_[_loc6_];
            _loc2_ = int(param1[_loc7_]);
            if(_type == 1)
            {
               _loc8_ = "<font color=\'#f8c071\'>+" + _loc2_ + "</font>";
            }
            else
            {
               _loc8_ = "<font color=\'#00e430\'>+" + _loc2_ + "</font>";
            }
            _loc5_ = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerBattleBeastPropItem.propText");
            _loc5_.htmlText = LanguageMgr.GetTranslation("DragonTalkerTalismanTips.mainAttText.text" + _loc7_,_loc8_);
            _propContiner.appendItem(_loc5_);
            _loc6_++;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_titleText);
         _titleText = null;
         ObjectUtils.disposeObject(_propContiner);
         _propContiner = null;
         ObjectUtils.disposeObject(_newAvatarText);
         _newAvatarText = null;
         ObjectUtils.disposeObject(_maxImage);
         _maxImage = null;
         super.dispose();
      }
   }
}

