package goldensheep
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.goldensheep.GoldenSheepModel;
   import mvc.module.goldensheep.GoldenSheepRecordInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.GoldenSheepManager;
   import yishi.view.community.BaseItemView;
   
   public class GoldenSheepItemView extends Sprite implements Disposeable
   {
      
      private var _bg:Image;
      
      private var _nameTxt:FilterFrameText;
      
      private var _rewardItemView:BaseItemView;
      
      private var _rewardTxt:FilterFrameText;
      
      private var _luckyFlag:Image;
      
      private var _model:GoldenSheepModel = GoldenSheepManager.instance.model;
      
      private var _data:GoldenSheepRecordInfo;
      
      public function GoldenSheepItemView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("goldensheep.GoldenSheepItemView.bg");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("goldensheep.GoldenSheepItemView.nameTxt");
         _rewardItemView = ComponentFactory.Instance.creatCustomObject("goldensheep.GoldenSheepItemView.rewardItemView");
         _rewardTxt = ComponentFactory.Instance.creatComponentByStylename("goldensheep.GoldenSheepItemView.rewardTxt");
         _luckyFlag = ComponentFactory.Instance.creatComponentByStylename("goldensheep.GoldenSheepItemView.luckyFlag");
         _nameTxt.setFrame(1);
         _rewardTxt.setFrame(1);
         _luckyFlag.visible = false;
         addChild(_bg);
         addChild(_nameTxt);
         addChild(_rewardItemView);
         addChild(_rewardTxt);
         addChild(_luckyFlag);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_rewardItemView);
         _rewardItemView = null;
         ObjectUtils.disposeObject(_rewardTxt);
         _rewardTxt = null;
         ObjectUtils.disposeObject(_luckyFlag);
         _luckyFlag = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function get data() : GoldenSheepRecordInfo
      {
         return _data;
      }
      
      public function set data(param1:GoldenSheepRecordInfo) : void
      {
         var _loc2_:GoodsInfo = null;
         _data = param1;
         if(data)
         {
            _loc2_ = new GoodsInfo();
            _loc2_.templateId = _model.rewardId;
            _nameTxt.text = data.nickName;
            _rewardItemView.data = _loc2_;
            _rewardTxt.text = LanguageMgr.GetTranslation("goldensheep.GoldenSheepItemView.dropTips",data.money);
            if(data.isBest)
            {
               _nameTxt.setFrame(2);
               _rewardTxt.setFrame(2);
               _luckyFlag.visible = true;
            }
            else
            {
               _nameTxt.setFrame(1);
               _rewardTxt.setFrame(1);
               _luckyFlag.visible = false;
            }
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
      }
   }
}

