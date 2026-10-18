package war2023.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.war2023.SecretWarModel;
   import mvc.module.war2023.info.SecretWarRankInfo;
   import war2023.item.SecretwarResultRankListItem;
   import war2023.item.SecretwarResultRankOneItem;
   import yishi.manager.SecretWarManager;
   
   public class SecretwarResultListView extends Sprite
   {
      
      private var _rankTxt:FilterFrameText;
      
      private var _rankNameTxt:FilterFrameText;
      
      private var _serverNameTxt:FilterFrameText;
      
      private var _attackCountTxt:FilterFrameText;
      
      private var _getBiuldTxt:FilterFrameText;
      
      private var _getResTxt:FilterFrameText;
      
      private var _fightScoreTxt:FilterFrameText;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _rankInfoList:SecretwarResultRankListItem;
      
      private var _oneItem:SecretwarResultRankOneItem;
      
      public function SecretwarResultListView()
      {
         super();
         initView();
         initData();
      }
      
      protected function initView() : void
      {
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("duskarea.DuskAreaPointRankFrameRankTxt");
         _rankNameTxt = ComponentFactory.Instance.creatComponentByStylename("duskarea.DuskAreaPointRankFrameRankNameTxt");
         _serverNameTxt = ComponentFactory.Instance.creatComponentByStylename("duskarea.DuskAreaPointRankFrameRankServerTxt");
         _attackCountTxt = ComponentFactory.Instance.creatComponentByStylename("duskarea.DuskAreaPointRankFrameAttackCountTxt");
         _getBiuldTxt = ComponentFactory.Instance.creatComponentByStylename("duskarea.DuskAreaPointRankFrameGetBiuldTxtTxt");
         _getResTxt = ComponentFactory.Instance.creatComponentByStylename("duskarea.DuskAreaPointRankFrameGetResTxtTxt");
         _fightScoreTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.resultFightScoreTxt");
         _rankInfoList = ComponentFactory.Instance.creatCustomObject("war2023.item.SecretwarResultRankListItem");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("duskarea.DuskAreaPointRankFrame.ScrollPanel");
         _oneItem = new SecretwarResultRankOneItem();
         _oneItem.isSelf = true;
         _scrollPanel.setView(_rankInfoList);
         _scrollPanel.invalidateViewport();
         addChild(_rankTxt);
         _rankTxt.text = LanguageMgr.GetTranslation("map.campaign.view.frame.duskarea.DuskAreaPointRankFrame.rankTxt");
         addChild(_rankNameTxt);
         _rankNameTxt.text = LanguageMgr.GetTranslation("map.campaign.view.frame.duskarea.DuskAreaPointRankFrame.rankNameTxt");
         addChild(_serverNameTxt);
         _serverNameTxt.text = LanguageMgr.GetTranslation("sort.view.MemberTitleView.serverName");
         addChild(_attackCountTxt);
         _attackCountTxt.text = LanguageMgr.GetTranslation("map.campaign.view.frame.duskarea.DuskAreaPointRankFrame.attackCountTxt");
         addChild(_getBiuldTxt);
         _getBiuldTxt.text = LanguageMgr.GetTranslation("secretwar.rank.zl");
         addChild(_getResTxt);
         _getResTxt.text = LanguageMgr.GetTranslation("map.campaign.view.frame.duskarea.DuskAreaPointRankFrame.getResTxt");
         addChild(_fightScoreTxt);
         _fightScoreTxt.text = LanguageMgr.GetTranslation("secretwar.fightScore");
         addChild(_scrollPanel);
         addChild(_oneItem);
         _oneItem.y = 345;
         _scrollPanel.width = 740;
      }
      
      private function initData() : void
      {
         var _loc5_:SecretWarRankInfo = null;
         var _loc4_:String = null;
         var _loc3_:Array = model.resultInfo.allkList;
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         if(_loc3_ != null)
         {
            _loc1_ = int(_loc3_.length);
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _loc5_ = _loc3_[_loc2_];
               _loc5_.rank = _loc2_ + 1;
               _loc4_ = _loc5_.userId + "_" + _loc5_.serverName;
               if(_loc4_ == SecretWarManager.Instance.model.selfPlay.key)
               {
                  _oneItem.data = _loc5_;
               }
               _loc2_++;
            }
            _rankInfoList.refreshMemberList(_loc3_);
         }
         _scrollPanel.setView(_rankInfoList);
         _scrollPanel.invalidateViewport();
      }
      
      private function get model() : SecretWarModel
      {
         return SecretWarManager.Instance.model;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_rankTxt);
         _rankTxt = null;
         ObjectUtils.disposeObject(_rankNameTxt);
         _rankNameTxt = null;
         ObjectUtils.disposeObject(_attackCountTxt);
         _attackCountTxt = null;
         ObjectUtils.disposeObject(_rankInfoList);
         _rankInfoList = null;
         ObjectUtils.disposeObject(_getResTxt);
         _getResTxt = null;
         ObjectUtils.disposeObject(_getBiuldTxt);
         _getBiuldTxt = null;
         ObjectUtils.disposeObject(_fightScoreTxt);
         _fightScoreTxt = null;
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

