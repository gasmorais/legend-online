package marry.room
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.MarryQualityData;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.BaseItemView;
   
   public class MarryRoomLefttView extends Sprite implements Disposeable
   {
      
      private var _bg:MutipleImage;
      
      private var _title:FilterFrameText;
      
      private var _describe:Bitmap;
      
      private var _carriageIcon:BaseIconView;
      
      private var _discText:FilterFrameText;
      
      private var _rewardContainer:SimpleTileList;
      
      public function MarryRoomLefttView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("MarryRoomLefttView.bg");
         _title = ComponentFactory.Instance.creatComponentByStylename("MarryRoomLefttView.title");
         _describe = ComponentFactory.Instance.creatBitmap("asset.marry.roomDescribeText");
         _rewardContainer = ComponentFactory.Instance.creatCustomObject("marry.rewardContainer",[4]);
         _discText = ComponentFactory.Instance.creatComponentByStylename("marry.marryCarriageDesc");
         _discText.text = LanguageMgr.GetTranslation("marry.marryCarriage.carriageDesc");
         _carriageIcon = ComponentFactory.Instance.creatCustomObject("MarryRoomLefttView.rewardIcon");
         _carriageIcon.icon = IconFactory.getMarryHorseIcon();
         addChild(_bg);
         addChild(_title);
         _title.text = LanguageMgr.GetTranslation("marry.propose.MarryRewardFrame1.title");
         addChild(_describe);
         addChild(_rewardContainer);
         _rewardContainer.x = 18;
         _rewardContainer.y = 58;
         addChild(_discText);
         _discText.x = 78;
         _discText.y = 215;
         addChild(_carriageIcon);
         _carriageIcon.x = 9;
         _carriageIcon.y = 214;
         addReward();
      }
      
      private function addReward() : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc1_:BaseItemView = null;
         var _loc4_:GoodsInfo = null;
         if(temp)
         {
            _loc2_ = temp.Rewards.split("|");
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               if(_loc2_[_loc3_] != "")
               {
                  _loc1_ = ComponentFactory.Instance.creatCustomObject("MarryRoomView.rewardItem");
                  _loc4_ = new GoodsInfo();
                  _loc4_.templateId = _loc2_[_loc3_].split(",")[0];
                  _loc4_.count = _loc2_[_loc3_].split(",")[1];
                  _loc1_.data = _loc4_;
                  _rewardContainer.addChild(_loc1_);
               }
               _loc3_++;
            }
         }
         _rewardContainer.refreshChildPos();
      }
      
      private function get temp() : MarryQualityData
      {
         return TempleteManager.instance.getMarryQualityTemplateCate.getTempById(1);
      }
      
      public function dispose() : void
      {
         if(_bg)
         {
            _bg.dispose();
         }
         _bg = null;
         if(_title)
         {
            _title.dispose();
         }
         _title = null;
         ObjectUtils.disposeObject(_describe);
         _describe = null;
         ObjectUtils.disposeObject(_discText);
         _discText = null;
         ObjectUtils.disposeObject(_carriageIcon);
         _carriageIcon = null;
         if(_rewardContainer)
         {
            _rewardContainer.dispose();
         }
         _rewardContainer = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

