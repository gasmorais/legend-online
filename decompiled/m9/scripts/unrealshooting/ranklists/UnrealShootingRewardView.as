package unrealshooting.ranklists
{
   import bag.datas.GoodsSonType;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class UnrealShootingRewardView extends Component
   {
      
      public static const GOODS_ID1:int = -200;
      
      public static const GOODS_ID2:int = 2120050;
      
      public static const GOODS_ID3:int = 2060044;
      
      public static const GOODS_ID4:int = 208001;
      
      private const MINSCORE:int = 3000;
      
      private var _bg:Image;
      
      private var _prize1:Image;
      
      private var _prize2:Image;
      
      private var _prize3:Image;
      
      private var _fourthTxt:FilterFrameText;
      
      private var _fifthTxt:FilterFrameText;
      
      private var _sixthTxt:FilterFrameText;
      
      private var _seventhTxt:FilterFrameText;
      
      private var _templeContainer:Sprite;
      
      private var _templeRankList:Array = [];
      
      private var _rewardDic:Dictionary;
      
      public function UnrealShootingRewardView()
      {
         super();
         _rewardDic = TempleteManager.instance.unrealShootingRewardTempCate.getTemplates();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRewardView.bg");
         _prize1 = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRewardView.prize1");
         _prize2 = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRewardView.prize2");
         _prize3 = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRewardView.prize3");
         _fourthTxt = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRewardView.fourth");
         _fifthTxt = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRewardView.fifth");
         _sixthTxt = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRewardView.sixth");
         _seventhTxt = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRewardView.seventh");
         _templeContainer = new Sprite();
         addChild(_bg);
         addChild(_prize1);
         addChild(_prize2);
         addChild(_prize3);
         addChild(_fourthTxt);
         addChild(_fifthTxt);
         addChild(_sixthTxt);
         addChild(_seventhTxt);
         addChild(_templeContainer);
         for(var _loc1_:String in _rewardDic)
         {
            if(_templeRankList.indexOf(int(_loc1_)) < 0)
            {
               _templeRankList.push(int(_loc1_));
            }
         }
         _templeRankList.sort(sortFun);
         _fourthTxt.text = LanguageMgr.GetTranslation("unrealshooting.UnrealShootingRewardView.str01",_templeRankList[3] + 1,_templeRankList[4]);
         _fifthTxt.text = LanguageMgr.GetTranslation("unrealshooting.UnrealShootingRewardView.str01",_templeRankList[4] + 1,_templeRankList[5]);
         _sixthTxt.text = LanguageMgr.GetTranslation("unrealshooting.UnrealShootingRewardView.str01",_templeRankList[5] + 1,_templeRankList[6]);
         _seventhTxt.text = LanguageMgr.GetTranslation("unrealshooting.UnrealShootingRewardView.str05",3000);
         addTempleRewards();
      }
      
      private function sortFun(param1:int, param2:int) : int
      {
         if(param1 < param2)
         {
            return -1;
         }
         if(param1 > param2)
         {
            return 1;
         }
         return 0;
      }
      
      private function unInitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_prize1);
         _prize1 = null;
         ObjectUtils.disposeObject(_prize2);
         _prize2 = null;
         ObjectUtils.disposeObject(_prize3);
         _prize3 = null;
         ObjectUtils.disposeObject(_fourthTxt);
         _fourthTxt = null;
         ObjectUtils.disposeObject(_fifthTxt);
         _fifthTxt = null;
         ObjectUtils.disposeObject(_sixthTxt);
         _sixthTxt = null;
         ObjectUtils.disposeObject(_seventhTxt);
         _seventhTxt = null;
         ObjectUtils.disposeAllChildren(_templeContainer);
         ObjectUtils.disposeObject(_templeContainer);
         _templeContainer = null;
      }
      
      override public function dispose() : void
      {
         unInitView();
         super.dispose();
      }
      
      private function addTempleRewards() : void
      {
         var _loc6_:BaseItemView = null;
         var _loc4_:GoodsInfo = null;
         var _loc7_:FilterFrameText = null;
         var _loc3_:TextButton = null;
         var _loc5_:int = 0;
         var _loc2_:Array = _rewardDic[_templeRankList[1]];
         var _loc1_:int = int(_loc2_.length);
         _loc5_;
         while(_loc5_ < _loc1_)
         {
            _loc6_ = ComponentFactory.Instance.creatCustomObject("core.BaseItemView");
            _loc7_ = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRewardView.itemName");
            _loc6_.x = 150 + _loc5_ % 5 * 200;
            _loc6_.y = 27;
            _loc4_ = new GoodsInfo();
            _loc4_.templateId = _loc2_[_loc5_].TemplateId;
            _loc6_.data = _loc4_ as GoodsInfo;
            _loc7_.htmlText = getGoodsCount(_loc4_,_loc2_[_loc5_].Count);
            _loc7_.x = _loc6_.x + (_loc6_.displayWidth - _loc7_.width) / 2;
            _loc7_.y = _loc6_.y + _loc6_.displayHeight;
            _templeContainer.addChild(_loc6_);
            _templeContainer.addChild(_loc7_);
            _loc5_++;
         }
         _loc2_ = _rewardDic[_templeRankList[2]];
         _loc1_ = int(_loc2_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc1_)
         {
            _loc6_ = ComponentFactory.Instance.creatCustomObject("core.BaseItemView");
            _loc7_ = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRewardView.itemName");
            _loc6_.x = 150 + _loc5_ % 5 * 200;
            _loc6_.y = 107;
            _loc4_ = new GoodsInfo();
            _loc4_.templateId = _loc2_[_loc5_].TemplateId;
            _loc6_.data = _loc4_ as GoodsInfo;
            _loc7_.htmlText = getGoodsCount(_loc4_,_loc2_[_loc5_].Count);
            _loc7_.x = _loc6_.x + (_loc6_.displayWidth - _loc7_.width) / 2;
            _loc7_.y = _loc6_.y + _loc6_.displayHeight;
            _templeContainer.addChild(_loc6_);
            _templeContainer.addChild(_loc7_);
            _loc5_++;
         }
         _loc2_ = _rewardDic[_templeRankList[3]];
         _loc1_ = int(_loc2_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc1_)
         {
            _loc6_ = ComponentFactory.Instance.creatCustomObject("core.BaseItemView");
            _loc7_ = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRewardView.itemName");
            _loc6_.x = 150 + _loc5_ % 5 * 200;
            _loc6_.y = 187;
            _loc4_ = new GoodsInfo();
            _loc4_.templateId = _loc2_[_loc5_].TemplateId;
            _loc6_.data = _loc4_ as GoodsInfo;
            _loc7_.htmlText = getGoodsCount(_loc4_,_loc2_[_loc5_].Count);
            _loc7_.x = _loc6_.x + (_loc6_.displayWidth - _loc7_.width) / 2;
            _loc7_.y = _loc6_.y + _loc6_.displayHeight;
            _templeContainer.addChild(_loc6_);
            _templeContainer.addChild(_loc7_);
            _loc5_++;
         }
         _loc2_ = _rewardDic[_templeRankList[4]];
         _loc1_ = int(_loc2_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc1_)
         {
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRewardView.itemNameBtn");
            _loc3_.y = _fourthTxt.y - 3;
            _loc3_.x = 150 + _loc5_ % 5 * 170;
            _loc4_ = new GoodsInfo();
            _loc4_.templateId = _loc2_[_loc5_].TemplateId;
            _loc3_.tipData = _loc4_;
            _loc3_.text = getGoodsCount(_loc4_,_loc2_[_loc5_].Count);
            _templeContainer.addChild(_loc3_);
            _loc5_++;
         }
         _loc2_ = _rewardDic[_templeRankList[5]];
         _loc1_ = int(_loc2_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc1_)
         {
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRewardView.itemNameBtn");
            _loc3_.y = _fifthTxt.y - 3;
            _loc3_.x = 150 + _loc5_ % 5 * 170;
            _loc4_ = new GoodsInfo();
            _loc4_.templateId = _loc2_[_loc5_].TemplateId;
            _loc3_.tipData = _loc4_;
            _loc3_.text = getGoodsCount(_loc4_,_loc2_[_loc5_].Count);
            _templeContainer.addChild(_loc3_);
            _loc5_++;
         }
         _loc2_ = _rewardDic[_templeRankList[6]];
         _loc1_ = int(_loc2_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc1_)
         {
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRewardView.itemNameBtn");
            _loc3_.y = _sixthTxt.y - 3;
            _loc3_.x = 150 + _loc5_ % 5 * 170;
            _loc4_ = new GoodsInfo();
            _loc4_.templateId = _loc2_[_loc5_].TemplateId;
            _loc3_.tipData = _loc4_;
            _loc3_.text = getGoodsCount(_loc4_,_loc2_[_loc5_].Count);
            _templeContainer.addChild(_loc3_);
            _loc5_++;
         }
         _loc2_ = _rewardDic[_templeRankList[0]];
         _loc1_ = int(_loc2_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc1_)
         {
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRewardView.itemNameBtn");
            _loc3_.y = _seventhTxt.y - 3;
            _loc3_.x = 175 + _loc5_ % 5 * 170;
            _loc4_ = new GoodsInfo();
            _loc4_.templateId = _loc2_[_loc5_].TemplateId;
            _loc3_.tipData = _loc4_;
            _loc3_.text = getGoodsCount(_loc4_,_loc2_[_loc5_].Count);
            _templeContainer.addChild(_loc3_);
            _loc5_++;
         }
      }
      
      private function getGoodsCount(param1:GoodsInfo, param2:int) : String
      {
         return "<font color=\'" + GoodsSonType.getColorByProfile(param1.templateInfo.Profile) + "\'>" + param1.templateInfo.TemplateName + "*" + param2 + "</font>";
      }
   }
}

