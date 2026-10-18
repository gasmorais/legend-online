package carnvial.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.CarnivalPlayGroundTemplateInfo;
   import yishi.manager.CarnivalManager;
   import yishi.view.community.BaseItemView;
   
   public class CarnivalGameItem extends Sprite
   {
      
      private const TYPE_1:int = 1;
      
      private const TYPE_2:int = 2;
      
      private const TYPE_3:int = 3;
      
      private var _bg:Bitmap;
      
      private var _title:Bitmap;
      
      private var _gameIcons:ScaleFrameImage;
      
      private var _gameStartBtn:BaseButton;
      
      private var _gameRewardTxt:FilterFrameText;
      
      private var _gameRwHbox:HBox;
      
      private var _gameNTitle:FilterFrameText;
      
      private var _tempInfo:CarnivalPlayGroundTemplateInfo;
      
      private var _itemList:Array = [];
      
      public function CarnivalGameItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.carniver.game.bg");
         _title = ComponentFactory.Instance.creatBitmap("asset.carniver.game.title");
         _gameIcons = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.gameIcons");
         _gameStartBtn = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.gameStartBtn");
         _gameRewardTxt = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.gameRewardTxt");
         _gameRwHbox = ComponentFactory.Instance.creatCustomObject("ui.carnival.gameRwHbox");
         _gameNTitle = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.gameNTitle");
         addChild(_bg);
         addChild(_title);
         addChild(_gameIcons);
         addChild(_gameStartBtn);
         addChild(_gameRewardTxt);
         addChild(_gameRwHbox);
         addChild(_gameNTitle);
      }
      
      private function initEvent() : void
      {
         _gameStartBtn.addEventListener("click",startHandler);
      }
      
      private function removeEvent() : void
      {
         _gameStartBtn.removeEventListener("click",startHandler);
      }
      
      private function startHandler(param1:MouseEvent) : void
      {
         if(!_tempInfo)
         {
            return;
         }
         CarnivalManager.Instance.opRequest(9,_tempInfo.Type);
      }
      
      public function refreshView(param1:String) : void
      {
         var _loc6_:Array = null;
         var _loc2_:Array = null;
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
         if(_tempInfo == null)
         {
            return;
         }
         if(param1 != "")
         {
            _loc6_ = param1.split("|");
            _loc4_ = false;
            for each(var _loc3_:String in _loc6_)
            {
               _loc2_ = _loc3_.split(",");
               if(int(_loc2_[0]) == _tempInfo.Type)
               {
                  _loc5_ = _tempInfo.PlayCount - int(_loc2_[1]);
                  if(_loc5_ < 0)
                  {
                     _loc5_ = 0;
                  }
                  _gameRewardTxt.text = LanguageMgr.GetTranslation("carnival.game.time",_loc5_);
                  _loc4_ = true;
                  break;
               }
            }
            if(!_loc4_)
            {
               _gameRewardTxt.text = LanguageMgr.GetTranslation("carnival.game.time",_tempInfo.PlayCount);
            }
         }
         else
         {
            _gameRewardTxt.text = LanguageMgr.GetTranslation("carnival.game.time",_tempInfo.PlayCount);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         for each(var _loc1_:DisplayObject in _itemList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _itemList = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_gameIcons);
         _gameIcons = null;
         ObjectUtils.disposeObject(_gameStartBtn);
         _gameStartBtn = null;
         ObjectUtils.disposeObject(_gameRewardTxt);
         _gameRewardTxt = null;
         ObjectUtils.disposeObject(_gameRwHbox);
         _gameRwHbox = null;
         ObjectUtils.disposeObject(_gameNTitle);
         _gameNTitle = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function set tempInfo(param1:CarnivalPlayGroundTemplateInfo) : void
      {
         _tempInfo = param1;
         if(_tempInfo)
         {
            switch(int(_tempInfo.Type) - 1)
            {
               case 0:
                  _gameNTitle.text = LanguageMgr.GetTranslation("AirGardenGame.llk.title");
                  break;
               case 1:
                  _gameNTitle.text = LanguageMgr.GetTranslation("NewMemoryCardFrame.titleText.text");
                  break;
               case 2:
                  _gameNTitle.text = LanguageMgr.GetTranslation("AirGardenGame.fivecard.title");
            }
            _gameIcons.setFrame(_tempInfo.Type);
            _gameRwHbox.beginChanges();
            createGoodItem(_tempInfo.Item1,_tempInfo.ItemNum1);
            createGoodItem(_tempInfo.Item2,_tempInfo.ItemNum2);
            createGoodItem(_tempInfo.Item3,_tempInfo.ItemNum3);
            createGoodItem(_tempInfo.Item4,_tempInfo.ItemNum4);
            _gameRwHbox.commitChanges();
         }
      }
      
      private function createGoodItem(param1:int, param2:int) : void
      {
         if(param1 == 0)
         {
            return;
         }
         var _loc3_:BaseItemView = ComponentFactory.Instance.creatCustomObject("feedBackFrame.BaseItemView");
         var _loc4_:GoodsInfo = new GoodsInfo();
         _loc4_.templateId = param1;
         _loc4_.count = param2;
         _loc3_.data = _loc4_;
         _itemList.push(_loc3_);
         _gameRwHbox.addChild(_loc3_);
      }
   }
}

