package ancientartifact.view.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import mvc.module.ancientartifact.AncientArmoryInfo;
   import yishi.datas.templates.ArmoryTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public class AncientArmoryMarkItem extends Component
   {
      
      private var _back:Bitmap;
      
      private var _typeTitle:Bitmap;
      
      private var _typeTitleTxt:FilterFrameText;
      
      private var _valueTxt:FilterFrameText;
      
      private var _data:AncientArmoryInfo;
      
      private var _type:int;
      
      public function AncientArmoryMarkItem(param1:int)
      {
         super();
         _type = param1;
         initView();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.ancientartifact.armoryGradeItemIcon");
         _typeTitle = ComponentFactory.Instance.creatBitmap("asset.ancientartifact.armoryMaxIcon");
         _typeTitleTxt = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.armoryItemTitleTxt");
         _valueTxt = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.armoryItemValueTxt");
         addChild(_back);
         addChild(_typeTitle);
         addChild(_typeTitleTxt);
         addChild(_valueTxt);
         if(_type < 2)
         {
            _typeTitleTxt.text = LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.armoryMarkTitle1");
         }
         else
         {
            _typeTitleTxt.text = LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.armoryMarkTitle2");
         }
         _typeTitleTxt.y = _typeTitleTxt.numLines > 1 ? 22 : 30;
      }
      
      public function set data(param1:AncientArmoryInfo) : void
      {
         var _loc10_:int = 0;
         var _loc9_:int = 0;
         var _loc4_:int = 0;
         _data = param1;
         var _loc7_:int = 1;
         _typeTitle.visible = false;
         _typeTitleTxt.visible = true;
         if(_type == 1)
         {
            _loc7_ = int(param1.grades);
         }
         else if(_type == 2)
         {
            _loc7_ = param1.grades + 1;
         }
         else if(_type == 3)
         {
            _typeTitle.visible = true;
            _typeTitleTxt.visible = false;
            _loc7_ = int(param1.grades);
         }
         var _loc2_:ArmoryTemplateInfo = TempleteManager.instance.armoryTempCate.getTempInfoByTemplateId(_data.templateId,_data.profile);
         var _loc3_:String = "";
         var _loc5_:Array = ["Attacks","PhyDefence","MagicDefence","Live","Parry","Penetrate"];
         var _loc8_:Array = ["AttackAdd","PhyDefenceAdd","MagicDefenceAdd","LiveAdd","ParryAdd","PenetrateAdd"];
         var _loc6_:int = int(_loc5_.length);
         _loc10_ = 0;
         while(_loc10_ < _loc6_)
         {
            _loc9_ = int(_loc2_[_loc5_[_loc10_]]);
            _loc4_ = int(_loc2_[_loc8_[_loc10_]]) * _loc7_;
            if(_loc9_ > 0)
            {
               _loc3_ += LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.armoryMarkTxt0" + (_loc10_ + 1)) + (_loc4_ + _loc9_) + "\n";
            }
            _loc10_ += 1;
         }
         _valueTxt.htmlText = _loc3_;
         _valueTxt.setFrame(_data.profile + 1);
      }
      
      public function get data() : AncientArmoryInfo
      {
         return _data;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_typeTitle);
         _typeTitle = null;
         ObjectUtils.disposeObject(_typeTitleTxt);
         _typeTitleTxt = null;
         ObjectUtils.disposeObject(_valueTxt);
         _valueTxt = null;
         super.dispose();
      }
   }
}

