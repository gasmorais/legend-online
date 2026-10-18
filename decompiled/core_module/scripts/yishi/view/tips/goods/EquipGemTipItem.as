package yishi.view.tips.goods
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.GoodsHelp;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class EquipGemTipItem extends Sprite implements Disposeable
   {
      
      private var _notJoinImg:Bitmap;
      
      private var _lockImg:Bitmap;
      
      private var _gemItem:BaseIconView;
      
      private var _gemProfileImg:ScaleFrameImage;
      
      private var _effectTxt:FilterFrameText;
      
      private const TEMPLATE_NAME_LIST:Vector.<String> = new <String>["Attack","Defence","MagicAttack","MagicDefence","ForceHit","Live","Captain","StunAttr","Parry"];
      
      private const LANGUAGE_KEY_LIST:Vector.<String> = new <String>["armyII.ThaneAttributeView.Tip13","armyII.ThaneAttributeView.Tip14","armyII.ThaneAttributeView.Tip15","armyII.ThaneAttributeView.Tip16","armyII.ThaneAttributeView.Tip10","armyII.ThaneAttributeView.Tip11","armyII.ThaneAttributeView.Tip05","armyII.ThaneAttributeView.Tip27","armyII.ThaneAttributeView.Tip19"];
      
      public function EquipGemTipItem()
      {
         super();
         _notJoinImg = ComponentFactory.Instance.creatBitmap("asset.tips.equipGemBg");
         _lockImg = ComponentFactory.Instance.creatBitmap("asset.tips.equipHoldClosed02");
         _gemItem = ComponentFactory.Instance.creatCustomObject("tip.equipGemIcon");
         _gemProfileImg = ComponentFactory.Instance.creatComponentByStylename("tips.profileImg02");
         _effectTxt = ComponentFactory.Instance.creatComponentByStylename("tips.gemAddStr");
         addChild(_notJoinImg);
         addChild(_lockImg);
         addChild(_gemItem);
         addChild(_gemProfileImg);
         addChild(_effectTxt);
      }
      
      public function setData(param1:int, param2:int) : void
      {
         var _loc3_:GoodsTemplateInfo = null;
         if(param1 > 0)
         {
            _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1);
            _notJoinImg.visible = false;
            _lockImg.visible = false;
            _gemItem.visible = true;
            _gemProfileImg.visible = true;
            _gemProfileImg.setFrame(_loc3_.Profile);
            _gemItem.icon = IconFactory.getGoodsIconByTID(param1);
            _effectTxt.setFrame(3);
            _effectTxt.htmlText = getDiscription(param1,param2);
         }
         else
         {
            _notJoinImg.visible = true;
            _lockImg.visible = false;
            _effectTxt.htmlText = LanguageMgr.GetTranslation("yishi.view.tips.goods.InlayItem.value02");
            _effectTxt.setFrame(2);
            if(param1 == -1)
            {
               _effectTxt.htmlText = LanguageMgr.GetTranslation("yishi.view.tips.goods.InlayItem.value01");
               _effectTxt.setFrame(1);
               _lockImg.visible = true;
            }
            _gemItem.visible = false;
            _gemProfileImg.visible = false;
         }
         _effectTxt.width = 200;
         _effectTxt.height = 22;
         _effectTxt.x = 40;
         _effectTxt.y = 6;
      }
      
      private function getDiscription(param1:int, param2:int) : String
      {
         var _loc9_:* = 0;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc8_:* = 0;
         var _loc12_:Array = null;
         var _loc11_:GoodsTemplateInfo = null;
         var _loc7_:String = "";
         var _loc6_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1);
         var _loc5_:uint = TEMPLATE_NAME_LIST.length;
         var _loc10_:Vector.<uint> = new Vector.<uint>();
         _loc8_ = 0;
         while(_loc8_ < _loc5_)
         {
            _loc3_ = TEMPLATE_NAME_LIST[_loc8_];
            _loc4_ = LANGUAGE_KEY_LIST[_loc8_];
            _loc9_ = uint(_loc6_[_loc3_]);
            if(_loc9_ > 0)
            {
               _loc7_ += LanguageMgr.GetTranslation(_loc4_) + "+" + _loc9_ + " ";
               _loc10_.push(_loc9_);
            }
            _loc8_++;
         }
         if(_loc6_.SonType == 228)
         {
            _loc12_ = _loc7_.split(" ");
            _loc11_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1);
            switch(int(_loc10_.length) - 2)
            {
               case 0:
                  _loc7_ = _loc12_[0] + " " + getAddDiscription(_loc11_.Property5,param2,_loc10_[0]) + "\n" + _loc12_[1] + " " + getAddDiscription(_loc11_.Property6,param2,_loc10_[1]);
                  break;
               default:
                  _loc7_ += getAddDiscription(param1,param2);
            }
         }
         else
         {
            _loc7_ += getAddDiscription(param1,param2);
         }
         return _loc7_;
      }
      
      private function getAddDiscription(param1:int, param2:int, param3:int = -1) : String
      {
         var _loc5_:* = 0;
         var _loc6_:int = 0;
         var _loc4_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1);
         if(param2 == thane.id)
         {
            _loc5_ = uint(param3 > 0 ? param3 : _loc4_.totalAttribute);
            _loc6_ = _loc5_ * GoodsHelp.getJewelEffecyByGrade(thane.jewelGrades) / 100;
            if(thane.jewelGrades >= 80 && playerinfo.vocationGrades > 0)
            {
               _loc6_ = _loc5_ * GoodsHelp.getSeniorJewelEffecyByGrade(thane.seniorStoreGrade) / 100;
            }
            if(_loc6_ == 0)
            {
               return "";
            }
            return "<font color=\'#48d72a\'>+" + getConciseDiscription(_loc6_,_loc5_) + "</font>";
         }
         return "";
      }
      
      private function getConciseDiscription(param1:int, param2:int) : String
      {
         var _loc3_:int = GoodsHelp.getConciseValue(param1 + param2,thane.conciseGrades);
         if(_loc3_ == 0)
         {
            return "" + param1;
         }
         return param1 + "<font color=\'#00fffc\'>  +" + _loc3_ + "</font>";
      }
      
      private function getColorByType(param1:int) : int
      {
         var _loc2_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1);
         return _loc2_.Property1;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get playerinfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function dispose() : void
      {
         if(_notJoinImg)
         {
            ObjectUtils.disposeObject(_notJoinImg);
         }
         _notJoinImg = null;
         if(_lockImg)
         {
            ObjectUtils.disposeObject(_notJoinImg);
         }
         _notJoinImg = null;
         if(_gemItem)
         {
            ObjectUtils.disposeObject(_gemItem);
         }
         _gemItem = null;
         if(_effectTxt)
         {
            ObjectUtils.disposeObject(_effectTxt);
         }
         _effectTxt = null;
      }
   }
}

