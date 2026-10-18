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
   
   public class AncientArmoryGradeItem extends Component
   {
      
      private var _back:Bitmap;
      
      private var _itemView:AncientArmoryItem;
      
      private var _titleTxt:FilterFrameText;
      
      private var _valueTxt:FilterFrameText;
      
      private var _data:AncientArmoryInfo;
      
      private var _type:int;
      
      public function AncientArmoryGradeItem(param1:int)
      {
         super();
         _type = param1;
         initView();
         initEvent();
      }
      
      public function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.ancientartifact.armoryBack03");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.armoryItemTitleTxt");
         _valueTxt = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.armoryItemValueTxt");
         _itemView = ComponentFactory.Instance.creatCustomObject("ancientartifact.markArmoryItem",[1,0]);
         addChild(_back);
         addChild(_itemView);
         addChild(_titleTxt);
         addChild(_valueTxt);
         _itemView.x = 35;
         _itemView.y = 25;
         _titleTxt.x = 3;
         _valueTxt.x = 19;
         _valueTxt.y = 127;
         _titleTxt.text = LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.armoryMarkTitle" + _type);
         _titleTxt.y = _titleTxt.numLines > 1 ? 99 : 109;
         if(_type < 2)
         {
            _valueTxt.setFrame(1);
         }
         else
         {
            _valueTxt.setFrame(2);
         }
      }
      
      private function initEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function set data(param1:AncientArmoryInfo) : void
      {
         var _loc10_:int = 0;
         var _loc9_:int = 0;
         var _loc4_:int = 0;
         _data = param1;
         if(!_data)
         {
            _itemView.data = null;
            _valueTxt.htmlText = "";
            return;
         }
         var _loc7_:int = int(_data.profile);
         _itemView.data = _data;
         var _loc2_:ArmoryTemplateInfo = TempleteManager.instance.armoryTempCate.getTempInfoByTemplateId(_data.templateId,_loc7_);
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:String = "";
         var _loc5_:Array = ["Attacks","PhyDefence","MagicDefence","Live","Parry","Penetrate"];
         var _loc8_:Array = ["AttackAdd","PhyDefenceAdd","MagicDefenceAdd","LiveAdd","ParryAdd","PenetrateAdd"];
         var _loc6_:int = int(_loc5_.length);
         _loc10_ = 0;
         while(_loc10_ < _loc6_)
         {
            _loc9_ = int(_loc2_[_loc5_[_loc10_]]);
            _loc4_ = int(_loc2_[_loc8_[_loc10_]]) * _data.grades;
            if(_loc9_ > 0)
            {
               _loc3_ += LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.armoryMarkTxt0" + (_loc10_ + 1)) + (_loc9_ + _loc4_) + "\n";
            }
            _loc10_ += 1;
         }
         _valueTxt.htmlText = _loc3_;
         _valueTxt.setFrame(_loc7_ + 1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_itemView);
         _itemView = null;
         ObjectUtils.disposeObject(_titleTxt);
         _titleTxt = null;
         ObjectUtils.disposeObject(_valueTxt);
         _valueTxt = null;
         super.dispose();
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get data() : AncientArmoryInfo
      {
         return _data;
      }
   }
}

