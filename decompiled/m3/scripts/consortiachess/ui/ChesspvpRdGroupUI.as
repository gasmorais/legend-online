package consortiachess.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import consortiachess.view.ChesspvpRewardBgView;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import utils.LogicUtils;
   import yishi.manager.TempleteManager;
   
   public class ChesspvpRdGroupUI extends Sprite
   {
      
      protected var _bg:ChesspvpRewardBgView;
      
      protected var _rdBox1:VBox;
      
      protected var _rdTitlebg:Image;
      
      protected var _rdTitle1:FilterFrameText;
      
      protected var _rdLine1:Image;
      
      protected var _rdLine2:Image;
      
      protected var _rdBox2:VBox;
      
      protected var _rdTitle2:FilterFrameText;
      
      private var _groupTitle:GradientText;
      
      private var _type:int;
      
      private var _itemList:Array = [];
      
      public function ChesspvpRdGroupUI(param1:int)
      {
         super();
         _type = param1;
         initView();
         initData();
      }
      
      protected function initView() : void
      {
         _bg = new ChesspvpRewardBgView(_type);
         _rdBox1 = ComponentFactory.Instance.creatCustomObject("ui.chesspvp.rdBox1");
         _rdTitlebg = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rdTitlebg");
         _rdTitle1 = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rdTitle1");
         _rdLine1 = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rdLine1");
         _rdLine2 = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rdLine2");
         _rdBox2 = ComponentFactory.Instance.creatCustomObject("ui.chesspvp.rdBox2");
         _rdTitle2 = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rdTitle2");
         _groupTitle = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.reward.GTitleTxt");
         addChild(_bg);
         addChild(_rdBox1);
         addChild(_rdTitlebg);
         addChild(_rdTitle1);
         addChild(_rdLine1);
         addChild(_rdLine2);
         addChild(_rdBox2);
         addChild(_rdTitle2);
         addChild(_groupTitle);
         _groupTitle.text = LanguageMgr.GetTranslation("chesspvp.reward.gName" + (3 - _type));
         _rdTitle1.text = LanguageMgr.GetTranslation("chesspvp.reward.week");
         _rdTitle2.text = LanguageMgr.GetTranslation("chesspvp.reward.day");
      }
      
      private function initData() : void
      {
         var _loc1_:ChesspvpRewardUI = null;
         var _loc2_:int = 4 - _type;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:Array = TempleteManager.instance.chesspvpRankDropCate.getDropGoods(_loc2_);
         _rdBox1.beginChanges();
         _loc4_ = int(_loc3_ ? _loc3_.length : 0);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc1_ = new ChesspvpRewardUI(1);
            _loc1_.data = _loc3_[_loc5_];
            _rdBox1.addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc5_++;
         }
         _rdBox1.commitChanges();
         var _loc6_:Array = TempleteManager.instance.chesspvpFightDropCate.getDropGoods(_loc2_);
         _rdBox2.beginChanges();
         _loc4_ = int(_loc6_ ? _loc6_.length : 0);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc1_ = new ChesspvpRewardUI(2);
            _loc1_.data = _loc6_[_loc5_];
            _rdBox2.addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc5_++;
         }
         _rdBox2.commitChanges();
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_rdBox1);
         _rdBox1 = null;
         ObjectUtils.disposeObject(_rdTitlebg);
         _rdTitlebg = null;
         ObjectUtils.disposeObject(_rdTitle1);
         _rdTitle1 = null;
         ObjectUtils.disposeObject(_rdLine1);
         _rdLine1 = null;
         ObjectUtils.disposeObject(_rdLine2);
         _rdLine2 = null;
         ObjectUtils.disposeObject(_rdBox2);
         _rdBox2 = null;
         ObjectUtils.disposeObject(_rdTitle2);
         _rdTitle2 = null;
         ObjectUtils.disposeObject(_groupTitle);
         _groupTitle = null;
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

