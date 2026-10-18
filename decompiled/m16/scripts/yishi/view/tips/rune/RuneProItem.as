package yishi.view.tips.rune
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.RuneGemTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class RuneProItem extends Sprite
   {
      
      private var _xing:int;
      
      private var _back:Bitmap;
      
      private var _item:BaseIconView;
      
      private var _txt:FilterFrameText;
      
      public function RuneProItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _back = new Bitmap();
         _item = ComponentFactory.Instance.creatCustomObject("ui.tip.stone.equipInStoneItem.BaseItemViewIcon");
         _txt = ComponentFactory.Instance.creatComponentByStylename("tips.stone.proitemTxt");
         addChild(_back);
         addChild(_item);
         addChild(_txt);
      }
      
      public function set xing(param1:int) : void
      {
         if(_xing == param1)
         {
            return;
         }
         _xing = param1;
         _back.bitmapData = ComponentFactory.Instance.creatBitmapData("asset.army.stone.shape" + _xing);
      }
      
      public function set data(param1:GoodsInfo) : void
      {
         var _loc2_:String = null;
         var _loc4_:RuneGemTempInfo = null;
         _item.icon = IconFactory.getGoodsIconByTID(param1.templateId);
         var _loc3_:GoodsTemplateInfo = param1.templateInfo;
         if(param1.strengthenGrade > 0)
         {
            _loc4_ = TempleteManager.instance.runeGemInfoCate.getInfo(_loc3_.SonType,_loc3_.Property1,param1.strengthenGrade);
            _loc2_ = getPropertys(_loc4_);
         }
         else
         {
            _loc2_ = getPropertys(_loc3_);
         }
         _txt.text = _loc2_;
      }
      
      private function getPropertys(param1:Object) : String
      {
         var _loc2_:String = null;
         var _loc7_:int = 0;
         if(param1 == null)
         {
            return "";
         }
         var _loc6_:Array = ["Power","Agility","Intellect","Physique","Captain"];
         var _loc5_:int = int(_loc6_.length);
         var _loc3_:String = "";
         var _loc4_:int = 0;
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            _loc2_ = _loc6_[_loc7_];
            if(param1[_loc2_] > 0)
            {
               _loc4_ = int(param1[_loc2_]);
               _loc3_ = LanguageMgr.GetTranslation("army.stone." + _loc2_,_loc4_);
               break;
            }
            _loc7_++;
         }
         return _loc3_;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_item);
         _item = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

