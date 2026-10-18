package alchemical.makeview
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.alchemical.AlchemicalMakeFormulaInfo;
   import mvc.module.alchemical.AlchemicalModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.AlchemicalFormulaTempInfo;
   import yishi.manager.AlchemicalManager;
   
   public class AlchemicalMakeNoteFormulaItem extends Component
   {
      
      private var selectBack:Bitmap;
      
      private var formulaName:FilterFrameText;
      
      private var _tempInfo:AlchemicalFormulaTempInfo;
      
      private var _data:AlchemicalMakeFormulaInfo;
      
      private var _selected:Boolean;
      
      public function AlchemicalMakeNoteFormulaItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         selectBack = ComponentFactory.Instance.creatBitmap("asset.AlchemicalMakeNoteFormulaItem.selectBack");
         formulaName = ComponentFactory.Instance.creatComponentByStylename("AlchemicalMakeNoteFormulaItem.formulaName");
         addChild(selectBack);
         addChild(formulaName);
      }
      
      private function addEvent() : void
      {
         addEventListener("click",__formulaSelectHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__formulaSelectHandler);
      }
      
      private function __formulaSelectHandler(param1:MouseEvent) : void
      {
         model.selectFormulaInfo = _data;
      }
      
      public function get tempInfo() : AlchemicalFormulaTempInfo
      {
         return _tempInfo;
      }
      
      public function set tempInfo(param1:AlchemicalFormulaTempInfo) : void
      {
         _tempInfo = param1;
         if(!_tempInfo)
         {
            _data = null;
            this.tipData = null;
            return;
         }
         _data = new AlchemicalMakeFormulaInfo();
         _data.formulaId = tempInfo.Id;
         formulaName.text = tempInfo.Name;
         model.curScore >= tempInfo.NeedScore ? formulaName.setFrame(1) : formulaName.setFrame(2);
         if(model.curScore >= tempInfo.NeedScore)
         {
            isHasMaterial ? formulaName.setFrame(2) : formulaName.setFrame(1);
            this.tipData = null;
         }
         else
         {
            formulaName.setFrame(3);
            this.tipData = LanguageMgr.GetTranslation("AlchemicalMineItem.open.needScore",tempInfo.NeedScore);
         }
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         selectBack.visible = selected;
         if(_selected)
         {
            model.selectFormulaInfo = _data;
         }
      }
      
      public function get isHasMaterial() : Boolean
      {
         var _loc11_:Array = null;
         var _loc5_:int = 0;
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:Array = null;
         var _loc9_:int = 0;
         var _loc1_:int = 0;
         var _loc10_:GoodsInfo = null;
         var _loc12_:int = 0;
         var _loc4_:Boolean = false;
         var _loc2_:Array = [];
         if(tempInfo && tempInfo.Type == 1)
         {
            _loc2_ = tempInfo.NeedItem.split("|");
         }
         else
         {
            _loc2_ = _loc2_.concat(tempInfo.NeedItem);
         }
         _loc5_ = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc11_ = _loc2_[_loc5_].split(",");
            _loc8_ = int(_loc11_.length);
            _loc6_ = 0;
            _loc7_ = 0;
            while(_loc7_ < _loc8_)
            {
               _loc3_ = _loc11_[_loc7_].split(":");
               _loc9_ = int(_loc3_[0]);
               _loc1_ = int(_loc3_[1]);
               _loc10_ = model.getAlchemicalItemById(_loc9_);
               _loc12_ = int(_loc10_ ? _loc10_.count : 0);
               if(_loc12_ >= _loc1_)
               {
                  _loc6_++;
               }
               _loc7_++;
            }
            if(_loc6_ >= _loc8_)
            {
               _loc4_ = true;
               break;
            }
            _loc5_++;
         }
         return _loc4_;
      }
      
      private function get model() : AlchemicalModel
      {
         return AlchemicalManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(selectBack);
         selectBack = null;
         ObjectUtils.disposeObject(formulaName);
         formulaName = null;
         super.dispose();
      }
   }
}

