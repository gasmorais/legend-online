package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
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
   
   public class HeroGemTipItem extends Component
   {
      
      private var notJoinImg:Bitmap;
      
      private var lockImg:Bitmap;
      
      private var gemItem:BaseIconView;
      
      private var gemProfileImg:ScaleFrameImage;
      
      private var effectTxt:FilterFrameText;
      
      private var symbiotePrecent:int;
      
      public function HeroGemTipItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         notJoinImg = ComponentFactory.Instance.creatBitmap("asset.tips.equipGemBg");
         lockImg = ComponentFactory.Instance.creatBitmap("asset.tips.equipHoldClosed02");
         gemItem = ComponentFactory.Instance.creatCustomObject("tip.equipGemIcon");
         effectTxt = ComponentFactory.Instance.creatComponentByStylename("tips.gemAddStr");
         gemProfileImg = ComponentFactory.Instance.creatComponentByStylename("tips.profileImg02");
         addChild(notJoinImg);
         addChild(lockImg);
         addChild(gemItem);
         addChild(gemProfileImg);
         addChild(effectTxt);
      }
      
      public function setData(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:GoodsTemplateInfo = null;
         if(param1 > 0)
         {
            symbiotePrecent = param3;
            _loc4_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1);
            notJoinImg.visible = false;
            lockImg.visible = false;
            gemItem.visible = true;
            gemProfileImg.visible = true;
            gemProfileImg.setFrame(_loc4_.Profile);
            gemItem.icon = IconFactory.getGoodsIconByTID(param1);
            effectTxt.setFrame(3);
            effectTxt.htmlText = getDiscription(param1,param2);
         }
         else
         {
            notJoinImg.visible = true;
            lockImg.visible = false;
            effectTxt.htmlText = LanguageMgr.GetTranslation("yishi.view.tips.goods.InlayItem.value02");
            effectTxt.setFrame(2);
            if(param1 == -1)
            {
               effectTxt.htmlText = LanguageMgr.GetTranslation("yishi.view.tips.goods.InlayItem.value01");
               effectTxt.setFrame(1);
               lockImg.visible = true;
            }
            gemItem.visible = false;
            gemProfileImg.visible = false;
         }
         effectTxt.y = 9 - (effectTxt.numLines - 1) * 9;
      }
      
      private function getDiscription(param1:int, param2:int) : String
      {
         var _loc7_:int = 0;
         var _loc10_:String = null;
         var _loc3_:int = 0;
         var _loc12_:Array = null;
         var _loc11_:GoodsTemplateInfo = null;
         var _loc6_:String = "";
         var _loc4_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1);
         var _loc9_:Array = _loc4_.hasValueAtt;
         var _loc5_:int = int(_loc9_.length);
         var _loc8_:Vector.<uint> = new Vector.<uint>();
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            _loc10_ = _loc9_[_loc7_];
            _loc3_ = int(_loc4_[_loc10_]);
            _loc8_.push(_loc3_);
            _loc6_ += LanguageMgr.GetTranslation("DragonTalkerTalismanTips.mainAttText.text" + _loc10_,"");
            _loc7_++;
         }
         if(_loc4_.SonType == 228)
         {
            _loc12_ = _loc6_.split(" ");
            _loc11_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1);
            switch(int(_loc8_.length) - 2)
            {
               case 0:
                  _loc6_ = _loc12_[0] + " " + Math.floor(getAddDiscription(_loc11_.Property5,param2,_loc8_[0]) * symbiotePrecent / 100) + "\n" + _loc12_[1] + " " + Math.floor(getAddDiscription(_loc11_.Property6,param2,_loc8_[1]) * symbiotePrecent / 100);
                  break;
               default:
                  _loc6_ += Math.floor(getAddDiscription(param1,param2) * symbiotePrecent / 100);
            }
         }
         else
         {
            _loc6_ += Math.floor(getAddDiscription(param1,param2,_loc8_[0]) * symbiotePrecent / 100);
         }
         return _loc6_;
      }
      
      private function getAddDiscription(param1:int, param2:int, param3:int = -1) : int
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
            if(_loc6_ > 0)
            {
               _loc6_ += GoodsHelp.getConciseValue(_loc6_ + _loc5_,thane.conciseGrades);
            }
            return _loc5_ + _loc6_;
         }
         return 0;
      }
      
      private function get playerinfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(gemItem);
         gemItem = null;
         ObjectUtils.disposeObject(effectTxt);
         effectTxt = null;
         ObjectUtils.disposeObject(notJoinImg);
         notJoinImg = null;
         ObjectUtils.disposeObject(lockImg);
         lockImg = null;
         ObjectUtils.disposeObject(gemProfileImg);
         gemProfileImg = null;
         super.dispose();
      }
   }
}

