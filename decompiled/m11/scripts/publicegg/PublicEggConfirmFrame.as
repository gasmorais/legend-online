package publicegg
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.sumpassion.EggItemMsg;
   import com.road.yishi.proto.sumpassion.EggMsg;
   import flash.display.Bitmap;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class PublicEggConfirmFrame extends Frame implements IManualSize
   {
      
      private var _eggMsg:EggMsg;
      
      private var _bg:Bitmap;
      
      private var _beerImage:ScaleFrameImage;
      
      private var _smallBg:Bitmap;
      
      private var _rewardBtn:Image;
      
      private var _receivedImg:Bitmap;
      
      private var _leftTimeBg:Bitmap;
      
      private var _noteTxt:FilterFrameText;
      
      public function PublicEggConfirmFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,432,500);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("publicegg.PublicEggConfirmFrame.titleText");
         _bg = ComponentFactory.Instance.creatBitmap("asset.publicegg.egg.confirmBg");
         _beerImage = ComponentFactory.Instance.creatComponentByStylename("publicegg.confirm.beerFrameImage");
         _smallBg = ComponentFactory.Instance.creatBitmap("asset.publicegg.egg.confirmSmallBg");
         _rewardBtn = ComponentFactory.Instance.creatComponentByStylename("publicegg.egg.confirmRewardImg");
         _receivedImg = ComponentFactory.Instance.creatBitmap("asset.publicegg.egg.receivedImg");
         _leftTimeBg = ComponentFactory.Instance.creatBitmap("asset.publicegg.egg.leftTimeBg");
         _noteTxt = ComponentFactory.Instance.creatComponentByStylename("publicegg.PublicEggConfirmFrame.noteTxt");
         addToContent(_bg);
         addToContent(_beerImage);
         addToContent(_smallBg);
         addToContent(_rewardBtn);
         addToContent(_receivedImg);
         addToContent(_leftTimeBg);
         addToContent(_noteTxt);
         _noteTxt.text = LanguageMgr.GetTranslation("publicegg.PublicEggConfirmFrame.noteText");
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
      }
      
      private function refreshView() : void
      {
         var _loc6_:Bitmap = null;
         var _loc1_:BaseItemView = null;
         var _loc3_:GoodsInfo = null;
         var _loc4_:int = 0;
         var _loc2_:Boolean = false;
         if(!_eggMsg)
         {
            return;
         }
         var _loc5_:Array = _eggMsg.randomOpenTemps;
         _loc4_ = 0;
         while(_loc4_ < _loc5_.length)
         {
            _loc6_ = ComponentFactory.Instance.creatBitmap("asset.publicegg.egg.noOpenImg");
            _loc6_.x = 23 + int(_loc4_ % 5) * 75;
            _loc6_.y = 200 + int(_loc4_ / 5) * 75;
            addToContent(_loc6_);
            _loc1_ = ComponentFactory.Instance.creatCustomObject("publicegg.confirm.BaseItemView");
            _loc3_ = new GoodsInfo();
            _loc3_.templateId = _loc5_[_loc4_].templateId;
            _loc3_.count = _loc5_[_loc4_].counts;
            _loc3_.showCount = true;
            _loc1_.data = _loc3_;
            _loc1_.x = 23 + int(_loc4_ % 5) * 75;
            _loc1_.y = 200 + int(_loc4_ / 5) * 75;
            addToContent(_loc1_);
            _loc2_ = _loc5_[_loc4_].isOpen || !_loc5_[_loc4_].isHiden;
            _loc6_.visible = !_loc2_;
            _loc1_.visible = _loc2_;
            if(!_loc5_[_loc4_].isOpen && !_loc5_[_loc4_].isHiden)
            {
               _loc1_.filters = [UIFilter.getGrayFilter()];
            }
            _loc4_++;
         }
         if(_eggMsg.boxRewardState == 1)
         {
            _receivedImg.visible = true;
            _rewardBtn.filters = [UIFilter.getGrayFilter()];
         }
         else
         {
            _receivedImg.visible = false;
            _rewardBtn.filters = [UIFilter.getGrayFilter()];
         }
         _beerImage.setFrame(_eggMsg.profile);
         _rewardBtn.tipData = LanguageMgr.GetTranslation("publicegg.PublicEggView.boxBtn.tipData",getTimeStr(_eggMsg.boxRewardsTemps));
      }
      
      private function getTimeStr(param1:Array) : String
      {
         var _loc2_:EggItemMsg = null;
         var _loc3_:GoodsTemplateInfo = null;
         var _loc4_:int = 0;
         var _loc5_:String = "";
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc2_ = EggItemMsg(param1[_loc4_]);
            _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc2_.templateId);
            _loc5_ += _loc3_.TemplateName + "x" + _loc2_.counts;
            if(_loc4_ != param1.length - 1)
            {
               _loc5_ += "\n";
            }
            _loc4_++;
         }
         return _loc5_;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show(param1:EggMsg) : void
      {
         _eggMsg = param1;
         refreshView();
         LayerManager.Instance.addToLayer(this,3,true,true,1,0,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_beerImage);
         _beerImage = null;
         ObjectUtils.disposeObject(_smallBg);
         _smallBg = null;
         ObjectUtils.disposeObject(_rewardBtn);
         _rewardBtn = null;
         ObjectUtils.disposeObject(_receivedImg);
         _receivedImg = null;
         ObjectUtils.disposeObject(_leftTimeBg);
         _leftTimeBg = null;
         ObjectUtils.disposeObject(_noteTxt);
         _noteTxt = null;
         _eggMsg = null;
         super.dispose();
      }
   }
}

