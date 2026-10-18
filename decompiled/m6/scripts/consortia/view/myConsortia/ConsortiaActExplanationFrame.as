package consortia.view.myConsortia
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import mvc.module.dayGuide.DailyItemInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.ConsortiaManager;
   import yishi.utils.StringHelper;
   import yishi.view.community.BaseItemView;
   
   public class ConsortiaActExplanationFrame extends Frame
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _titleBg:Image;
      
      private var _titleImg:ScaleFrameImage;
      
      private var _rewardBg:Image;
      
      private var _rewardImg:Bitmap;
      
      private var _describe:FilterFrameText;
      
      private var _starTxt:FilterFrameText;
      
      private var _starHbox:HBox;
      
      private var _goodsBox:VBox;
      
      private var _sp1:Component;
      
      private var _sp2:Component;
      
      private var _currIndex:int = -1;
      
      public function ConsortiaActExplanationFrame()
      {
         super();
         initView();
         this.titleText = LanguageMgr.GetTranslation("consortia.view.myConsortia.ConsortiaActExplanationFrame.titleText");
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:BaseItemView = null;
         var _loc2_:GoodsInfo = null;
         _bg = ComponentFactory.Instance.creatComponentByStylename("consortia.actExplanation.Bg");
         _titleBg = ComponentFactory.Instance.creatComponentByStylename("consortia.Explanation.titleBg");
         _titleImg = ComponentFactory.Instance.creatComponentByStylename("consortia.actTitle");
         _rewardBg = ComponentFactory.Instance.creatComponentByStylename("consortia.rewardTitleBg");
         _rewardImg = ComponentFactory.Instance.creatBitmap("asset.consortia.rewardTitle");
         _describe = ComponentFactory.Instance.creatComponentByStylename("consortia.describeText");
         _starTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.starTxt");
         _starHbox = ComponentFactory.Instance.creatComponentByStylename("consortia.starHbox");
         _goodsBox = ComponentFactory.Instance.creatComponentByStylename("consortia.rewardGodosVbox");
         _sp1 = new Component();
         _sp2 = new Component();
         _titleImg.setFrame(1);
         addToContent(_bg);
         addToContent(_titleBg);
         addToContent(_titleImg);
         addToContent(_rewardBg);
         addToContent(_rewardImg);
         _rewardImg.x = 5;
         _rewardImg.y = 213;
         addToContent(_describe);
         _describe.text = "每周{invalid_utf8=228}{invalid_utf8=184}?、三、五晚上8点开启的，公会之间的对战玩法，产出大量的荣誉和勋章{invalid_utf8=227}??";
         addToContent(_starHbox);
         addToContent(_goodsBox);
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("consortia.act.BaseItemView");
            _loc2_ = new GoodsInfo();
            _loc2_.templateId = -500;
            _loc2_.count = 0;
            _loc1_.data = _loc2_;
            _loc1_.x = _loc3_ * 46;
            _sp1.addChild(_loc1_);
            _loc3_++;
         }
         _goodsBox.addChild(_sp1);
         _goodsBox.addChild(_sp2);
      }
      
      public function set currIndex(param1:int) : void
      {
         var _loc10_:DailyItemInfo = null;
         var _loc6_:int = 0;
         var _loc3_:BaseItemView = null;
         var _loc5_:GoodsInfo = null;
         var _loc4_:BaseItemView = null;
         var _loc11_:GoodsInfo = null;
         var _loc7_:int = 0;
         var _loc8_:BaseItemView = null;
         var _loc9_:GoodsInfo = null;
         if(_currIndex == param1)
         {
            return;
         }
         _currIndex = param1;
         _titleImg.setFrame(_currIndex);
         _starHbox.removeAllChild();
         clearDrop();
         if(_currIndex == 5)
         {
            _loc10_ = ConsortiaManager.instance.getDailyInfoById("27");
         }
         else if(_currIndex == 4)
         {
            _loc10_ = ConsortiaManager.instance.getDailyInfoById("27");
         }
         else
         {
            _loc10_ = ConsortiaManager.instance.getDailyInfoById(21 + _currIndex + "");
         }
         if(!_loc10_)
         {
            return;
         }
         _describe.text = _loc10_.Detail;
         if(StringHelper.isNullOrEmpty(_loc10_.DropList) || _loc10_.DropList == "0")
         {
            return;
         }
         var _loc2_:Array = _loc10_.DropList.split(",");
         if(_loc2_.length > 4)
         {
            _loc6_ = 0;
            while(_loc6_ < 4)
            {
               _loc3_ = ComponentFactory.Instance.creatCustomObject("consortia.act.BaseItemView");
               _loc5_ = new GoodsInfo();
               _loc5_.templateId = _loc2_[_loc6_];
               _loc5_.count = 0;
               _loc3_.data = _loc5_;
               _loc3_.x = _loc6_ * 46;
               _sp1.addChild(_loc3_);
               if(4 + _loc6_ <= _loc2_.length)
               {
                  _loc4_ = ComponentFactory.Instance.creatCustomObject("consortia.act.BaseItemView");
                  _loc11_ = new GoodsInfo();
                  _loc11_.templateId = _loc2_[4 + _loc6_];
                  _loc11_.count = 0;
                  _loc4_.data = _loc11_;
                  _loc4_.x = _loc6_ * 46;
                  _sp2.addChild(_loc4_);
               }
               _loc6_++;
            }
         }
         else
         {
            _loc7_ = 0;
            while(_loc7_ < _loc2_.length)
            {
               _loc8_ = ComponentFactory.Instance.creatCustomObject("consortia.act.BaseItemView");
               _loc9_ = new GoodsInfo();
               _loc9_.templateId = _loc2_[_loc7_];
               _loc9_.count = 0;
               _loc8_.data = _loc9_;
               _loc8_.x = _loc7_ * 46;
               _sp1.addChild(_loc8_);
               _loc7_++;
            }
         }
      }
      
      private function clearDrop() : void
      {
         ObjectUtils.disposeAllChildren(_sp1);
         ObjectUtils.disposeAllChildren(_sp2);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_titleBg);
         _titleBg = null;
         ObjectUtils.disposeObject(_titleImg);
         _titleImg = null;
         ObjectUtils.disposeObject(_rewardBg);
         _rewardBg = null;
         ObjectUtils.disposeObject(_rewardImg);
         _rewardImg = null;
         ObjectUtils.disposeObject(_describe);
         _describe = null;
         ObjectUtils.disposeObject(_starTxt);
         _starTxt = null;
         ObjectUtils.disposeObject(_starHbox);
         _starHbox = null;
         clearDrop();
         ObjectUtils.disposeObject(_sp1);
         _sp1 = null;
         ObjectUtils.disposeObject(_sp2);
         _sp2 = null;
         ObjectUtils.disposeObject(_goodsBox);
         _goodsBox = null;
         super.dispose();
      }
   }
}

