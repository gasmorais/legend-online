package consortia.view.wanted
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   
   public class GuildWantedRewardTipView extends Component
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _vBox:VBox;
      
      public function GuildWantedRewardTipView()
      {
         super();
         initView();
         refreshView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.commonTipBg");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("GuildWantedRewardTipView.vbox");
         addChild(_bg);
         addChild(_vBox);
      }
      
      private function refreshView() : void
      {
         var _loc1_:Array = null;
         var _loc4_:int = 0;
         var _loc2_:String = null;
         var _loc6_:int = 0;
         var _loc3_:FilterFrameText = null;
         var _loc7_:SimpleDictionary = TempleteManager.instance.guildWantedDropTempCate.getRewardList(3);
         var _loc8_:Array = _loc7_.keys;
         _loc8_.sort(indexSort);
         var _loc5_:String = "";
         _loc4_ = 0;
         while(_loc4_ < _loc7_.keys.length)
         {
            _loc2_ = _loc8_[_loc4_];
            _loc1_ = _loc7_[_loc2_];
            if(_loc4_ == _loc7_.keys.length - 1)
            {
               _loc5_ = getRankTxt(_loc2_,true);
            }
            else
            {
               _loc5_ = getRankTxt(_loc2_);
            }
            if(_loc1_.length > 0)
            {
               _loc6_ = 0;
               while(_loc6_ < _loc1_.length)
               {
                  if(_loc6_ == _loc1_.length - 1)
                  {
                     _loc5_ += getGoodsName(_loc1_[_loc6_].itemId) + "*" + _loc1_[_loc6_].count;
                  }
                  else
                  {
                     _loc5_ += getGoodsName(_loc1_[_loc6_].itemId) + "*" + _loc1_[_loc6_].count + "   ";
                  }
                  _loc6_++;
               }
            }
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("GuildWantedRewardTipView.rewardTxt");
            _loc3_.text = _loc5_;
            _vBox.addChild(_loc3_);
            _loc4_++;
         }
         _bg.width = _vBox.x + _vBox.width + 10;
         _bg.height = _vBox.y + _vBox.height + 10;
      }
      
      private function indexSort(param1:String, param2:String) : int
      {
         var _loc5_:Array = param1.split(",");
         var _loc3_:Array = param2.split(",");
         var _loc6_:int = int(_loc5_[0]);
         var _loc4_:int = int(_loc3_[0]);
         if(_loc6_ > _loc4_)
         {
            return 1;
         }
         if(_loc6_ == _loc4_)
         {
            return 0;
         }
         return -1;
      }
      
      private function getRankTxt(param1:String, param2:Boolean = false) : String
      {
         var _loc4_:String = "";
         var _loc3_:Array = param1.split(",");
         if(_loc3_.length == 1)
         {
            if(param2)
            {
               _loc4_ = LanguageMgr.GetTranslation("guildWantedRewardTipView.rankTxt.text3",_loc3_[0]);
            }
            else
            {
               _loc4_ = LanguageMgr.GetTranslation("guildWantedRewardTipView.rankTxt.text1",_loc3_[0]);
            }
         }
         else if(_loc3_.length > 1)
         {
            _loc4_ = LanguageMgr.GetTranslation("guildWantedRewardTipView.rankTxt.text2",_loc3_[0],_loc3_[_loc3_.length - 1]);
         }
         return _loc4_;
      }
      
      private function getGoodsName(param1:int) : String
      {
         return TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1).TemplateName;
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,7);
      }
      
      override public function dispose() : void
      {
         uintView();
         super.dispose();
      }
   }
}

