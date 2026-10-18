package ylex.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.ylex.ChildCampInfo;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ChildCampTempTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.view.base.ProgressPanel;
   import yishi.view.community.BaseItemView;
   
   public class YLXepedtionFightInfoView extends Sprite
   {
      
      public var _bigBg:Bitmap;
      
      public var _hasActiveFlg:Bitmap;
      
      public var _Ft1:Bitmap;
      
      public var _Ft2:Bitmap;
      
      public var _line:Bitmap;
      
      public var _dkActiveBtn:BaseButton;
      
      public var _Ft3:Bitmap;
      
      public var _dkRewardBox1:HBox;
      
      public var _dkRewardBox2:HBox;
      
      private var _progressBar:ProgressPanel;
      
      public var _attackText:FilterFrameText;
      
      public var _needResText:FilterFrameText;
      
      private var _data:ChildCampInfo;
      
      public function YLXepedtionFightInfoView()
      {
         super();
         initView();
      }
      
      public function get data() : ChildCampInfo
      {
         return _data;
      }
      
      public function set data(param1:ChildCampInfo) : void
      {
         var _loc3_:ChildCampTempTempInfo = null;
         var _loc2_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         _data = param1;
         if(_data)
         {
            _hasActiveFlg.visible = _data.isCover == 1 ? true : 0;
            _dkActiveBtn.visible = !_hasActiveFlg.visible;
            _loc3_ = TempleteManager.instance.childCampTempCate.getTempByGrade(_data.grade);
            if(_loc3_)
            {
               _loc2_ = int(_loc3_.getSneakCountByDiff(_data.difficulty));
               _progressBar.progressValue(_data.defenseCount,_loc2_);
               _loc4_ = _loc3_.getSneakAwardByDiff(_data.difficulty);
               if(_loc4_ != null)
               {
                  showRewards(_dkRewardBox1,_loc4_);
               }
               _loc4_ = _loc3_.getSneakFinshiAward(_data.difficulty);
               if(_loc4_ != null)
               {
                  showRewards(_dkRewardBox2,_loc4_);
               }
            }
            _loc5_ = data.sneakCount - data.defenseCount;
            _attackText.text = LanguageMgr.GetTranslation("ui.ylexpedition.attackText.text",_loc5_);
            if(_data.difficulty == 2)
            {
               _needResText.text = ConfigInfoManager.instance.getChildCampSneakCount2() + "";
            }
            else if(_data.difficulty == 3)
            {
               _needResText.text = ConfigInfoManager.instance.getChildCampSneakCount3() + "";
            }
            else
            {
               _needResText.text = "0";
            }
         }
      }
      
      private function showRewards(param1:HBox, param2:String) : void
      {
         var _loc4_:String = null;
         var _loc8_:Array = null;
         var _loc3_:BaseItemView = null;
         var _loc7_:GoodsInfo = null;
         var _loc6_:int = 0;
         var _loc9_:Array = param2.split("|");
         var _loc5_:int = int(_loc9_ ? _loc9_.length : 0);
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_ = _loc9_[_loc6_];
            _loc8_ = _loc4_.split(",");
            _loc3_ = ComponentFactory.Instance.creatCustomObject("feedBackFrame.BaseItemView");
            param1.addChild(_loc3_);
            _loc7_ = new GoodsInfo();
            _loc7_.templateId = int(_loc8_[0]);
            _loc7_.count = int(_loc8_[1]);
            _loc3_.data = _loc7_;
            _loc6_++;
         }
      }
      
      private function initView() : void
      {
         _bigBg = ComponentFactory.Instance.creatBitmap("asset.ylexdition.dk.bigBg");
         _hasActiveFlg = ComponentFactory.Instance.creatBitmap("asset.ylexdition.dk.hasActiveFlg");
         _Ft1 = ComponentFactory.Instance.creatBitmap("asset.ylexdition.dk.Ft1");
         _Ft2 = ComponentFactory.Instance.creatBitmap("asset.ylexdition.dk.Ft2");
         _line = ComponentFactory.Instance.creatBitmap("asset.ylexdition.dk.line");
         _dkActiveBtn = ComponentFactory.Instance.creatComponentByStylename("ui.ylexpedition.dkActiveBtn");
         _Ft3 = ComponentFactory.Instance.creatBitmap("asset.ylexdition.dk.Ft3");
         _dkRewardBox1 = ComponentFactory.Instance.creatCustomObject("ui.ylexpedition.dkRewardBox1");
         _dkRewardBox2 = ComponentFactory.Instance.creatCustomObject("ui.ylexpedition.dkRewardBox2");
         _progressBar = ComponentFactory.Instance.creatCustomObject("ui.ylexpedition.progressBar");
         _attackText = ComponentFactory.Instance.creatComponentByStylename("ui.ylexpedition.attackText");
         _needResText = ComponentFactory.Instance.creatComponentByStylename("ui.ylexpedition.needResText");
         addChild(_bigBg);
         addChild(_hasActiveFlg);
         addChild(_attackText);
         addChild(_Ft1);
         addChild(_Ft2);
         addChild(_line);
         addChild(_needResText);
         addChild(_dkActiveBtn);
         addChild(_Ft3);
         addChild(_dkRewardBox1);
         addChild(_dkRewardBox2);
         addChild(_progressBar);
         _progressBar.initView("asset.ylexdition.proBarBg","asset.ylexdition.proBar","ui.ylexpedition.progressBarTxt");
         _progressBar.progressValue(1,1);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bigBg);
         _bigBg = null;
         ObjectUtils.disposeObject(_hasActiveFlg);
         _hasActiveFlg = null;
         ObjectUtils.disposeObject(_Ft1);
         _Ft1 = null;
         ObjectUtils.disposeObject(_Ft2);
         _Ft2 = null;
         ObjectUtils.disposeObject(_line);
         _line = null;
         ObjectUtils.disposeObject(_dkActiveBtn);
         _dkActiveBtn = null;
         ObjectUtils.disposeObject(_attackText);
         _attackText = null;
         ObjectUtils.disposeObject(_Ft3);
         _Ft3 = null;
         ObjectUtils.disposeObject(_dkRewardBox1);
         _dkRewardBox1 = null;
         ObjectUtils.disposeObject(_dkRewardBox2);
         _dkRewardBox2 = null;
         ObjectUtils.disposeObject(_progressBar);
         _progressBar = null;
         ObjectUtils.disposeObject(_needResText);
         _needResText = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _data = null;
      }
   }
}

