package yishi.view.tips.goods
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.GoodsHelp;
   
   public class GoodAttributeItem extends Sprite implements Disposeable
   {
      
      private var _flagImg:Bitmap;
      
      private var _attributeName:FilterFrameText;
      
      private var _attributeValue:FilterFrameText;
      
      private var _attributeAdd:FilterFrameText;
      
      public function GoodAttributeItem()
      {
         super();
         _flagImg = ComponentFactory.Instance.creatBitmap("asset.tips.attributeFlag");
         _attributeName = ComponentFactory.Instance.creatComponentByStylename("tips.GoodAttackText");
         _attributeValue = ComponentFactory.Instance.creatComponentByStylename("tips.GoodAttackText");
         _attributeName.x = 14;
         _attributeValue.x = 50;
         _attributeAdd = ComponentFactory.Instance.creatComponentByStylename("tips.GoodAttackAddText");
         addChild(_flagImg);
         addChild(_attributeName);
         addChild(_attributeValue);
         addChild(_attributeAdd);
      }
      
      public function updateText(param1:String, param2:Number, param3:Number = 0, param4:Number = 0, param5:int = 0, param6:Boolean = false) : void
      {
         var _loc10_:int = 0;
         var _loc8_:String = null;
         var _loc7_:int = 0;
         var _loc9_:String = null;
         if(param6)
         {
            _attributeName.x = 0;
            _flagImg.visible = false;
            _attributeName.text = param1 + param2.toString();
            _attributeAdd.visible = false;
         }
         else
         {
            _attributeName.x = 14;
            _flagImg.visible = true;
            _attributeName.text = param1;
            _attributeValue.text = param2.toString();
            _loc10_ = getConciseValue(param3,param5);
            _loc8_ = _loc10_ > 0 ? "  +" + _loc10_ : "";
            _loc7_ = getConciseValue(param4,param5);
            _loc9_ = _loc7_ > 0 ? "  +" + _loc7_ : "";
            if(param3 > 0)
            {
               if(param4 > 0)
               {
                  _attributeAdd.text = "+" + (param3 + param4) + LanguageMgr.GetTranslation("yishi.view.tips.goods.GoodAttributeItem.text01") + param3 + LanguageMgr.GetTranslation("yishi.view.tips.goods.GoodAttributeItem.text02") + param4 + "）";
                  if(_loc8_.length > 0)
                  {
                     _loc8_ += "\n";
                  }
                  else
                  {
                     _loc8_ += " ";
                  }
                  _attributeAdd.htmlText = LanguageMgr.GetTranslation("yishi.view.tips.goods.GoodAttributeItem.text01") + " +" + param3 + "<font color=\'#00fffc\'>" + _loc8_ + "</font>" + LanguageMgr.GetTranslation("yishi.view.tips.goods.GoodAttributeItem.text02") + " +" + param4 + "<font color=\'#00fffc\'>" + _loc9_ + "</font>";
               }
               else
               {
                  _attributeAdd.text = "+" + param3 + LanguageMgr.GetTranslation("yishi.view.tips.goods.GoodAttributeItem.text01") + param3 + " ";
                  _attributeAdd.htmlText = LanguageMgr.GetTranslation("yishi.view.tips.goods.GoodAttributeItem.text01") + " +" + param3 + "<font color=\'#00fffc\'>" + _loc8_ + "</font>";
               }
            }
            else
            {
               _attributeAdd.text = "+" + param4 + LanguageMgr.GetTranslation("yishi.view.tips.goods.GoodAttributeItem.text03") + param4 + " ";
               _attributeAdd.htmlText = LanguageMgr.GetTranslation("yishi.view.tips.goods.GoodAttributeItem.text03") + " +" + param4 + "<font color=\'#00fffc\'>" + _loc9_ + "</font>";
            }
            _attributeAdd.x = _attributeValue.x + _attributeValue.textWidth;
            _attributeAdd.x = _attributeValue.x + _attributeValue.textWidth + 5;
            _attributeAdd.visible = param3 != 0 || param4 > 0;
            if(_attributeAdd.textWidth > 210)
            {
               _attributeAdd.x = 15;
               _attributeAdd.y = 18;
            }
            else
            {
               _attributeAdd.x = _attributeValue.x + _attributeValue.textWidth + 5;
               _attributeAdd.y = 0;
            }
            _attributeAdd.height = _attributeAdd.numLines * 18;
            _attributeValue.x = _attributeName.x + _attributeName.textWidth + 5;
            _attributeAdd.x = _attributeValue.x + _attributeValue.textWidth + 5;
         }
      }
      
      private function getConciseValue(param1:int, param2:int) : int
      {
         var _loc3_:int = 0;
         if(param2 == thane.id)
         {
            _loc3_ = GoodsHelp.getConciseValue(param1,thane.conciseGrades);
         }
         return _loc3_;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function enchantUpdateText(param1:GoodsInfo, param2:GoodsTemplateInfo) : void
      {
         var _loc3_:SkillTempInfo = null;
         if(param1.enchantSkillId)
         {
            _loc3_ = TempleteManager.instance.getSkillById(param1.enchantSkillId);
            _attributeName.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.GoodAttributeItem.text04");
            _attributeValue.x = 55;
            _attributeValue.width = 210;
            _attributeValue.text = _loc3_.Description;
            if(_loc3_.Description.length >= 18)
            {
               _attributeValue.height = 30;
            }
            else
            {
               _attributeValue.height = 18;
            }
            _attributeValue.wordWrap = true;
            _attributeValue.multiline = true;
            _attributeName.textFormatStyle = _attributeValue.textFormatStyle = "tips.goodsenchant_t1";
            _flagImg.visible = true;
            _attributeAdd.visible = false;
            _attributeValue.x = _attributeName.x + _attributeName.textWidth + 5;
         }
      }
      
      public function get TextWidth() : int
      {
         return _attributeAdd.textWidth;
      }
      
      public function dispose() : void
      {
         if(_flagImg)
         {
            ObjectUtils.disposeObject(_flagImg);
         }
         _flagImg = null;
         if(_attributeName)
         {
            _attributeName.dispose();
         }
         _attributeName = null;
         if(_attributeValue)
         {
            _attributeValue.dispose();
         }
         _attributeValue = null;
         if(_attributeAdd)
         {
            _attributeAdd.dispose();
         }
         _attributeAdd = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

