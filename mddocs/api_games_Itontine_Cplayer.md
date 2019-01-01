---
id: games_Itontine_Cplayer
title: Cplayer
---

<div class="contract-doc"><div class="contract"><h2 class="contract-header"><span class="contract-kind">contract</span> Cplayer</h2><div class="source">Source: <a href="https://github.com/FriendlyUser/solidity-smart-contracts//blob/v0.2.0/contracts/games/Itontine.sol" target="_blank">games/Itontine.sol</a></div></div><div class="index"><h2>Index</h2><ul><li><a href="games_Itontine_Cplayer.html#AddPlayer">AddPlayer</a></li><li><a href="games_Itontine_Cplayer.html#EditPlayer">EditPlayer</a></li><li><a href="games_Itontine_Cplayer.html#EditPlayer">EditPlayer</a></li><li><a href="games_Itontine_Cplayer.html#RemovePlayer">RemovePlayer</a></li><li><a href="games_Itontine_Cplayer.html#exist">exist</a></li><li><a href="games_Itontine_Cplayer.html#">fallback</a></li><li><a href="games_Itontine_Cplayer.html#findplayer">findplayer</a></li><li><a href="games_Itontine_Cplayer.html#getplayer">getplayer</a></li><li><a href="games_Itontine_Cplayer.html#onlyadmin">onlyadmin</a></li></ul></div><div class="reference"><h2>Reference</h2><div class="modifiers"><h3>Modifiers</h3><ul><li><div class="item modifier"><span id="onlyadmin" class="anchor-marker"></span><h4 class="name">onlyadmin</h4><div class="body"><code class="signature">modifier <strong>onlyadmin</strong><span>() </span></code><hr/></div></div></li></ul></div><div class="functions"><h3>Functions</h3><ul><li><div class="item function"><span id="AddPlayer" class="anchor-marker"></span><h4 class="name">AddPlayer</h4><div class="body"><code class="signature">function <strong>AddPlayer</strong><span>(string _name, uint256 _phonenumber) </span><span>public </span><span>returns  (bool) </span></code><hr/><dl><dt><span class="label-parameters">Parameters:</span></dt><dd><div><code>_name</code> - string</div><div><code>_phonenumber</code> - uint256</div></dd><dt><span class="label-return">Returns:</span></dt><dd>bool</dd></dl></div></div></li><li><div class="item function"><span id="EditPlayer" class="anchor-marker"></span><h4 class="name">EditPlayer</h4><div class="body"><code class="signature">function <strong>EditPlayer</strong><span>(string _name, uint256 _phonenumber, address _address, uint256 _id) </span><span>public </span><span>returns  (bool) </span></code><hr/><dl><dt><span class="label-parameters">Parameters:</span></dt><dd><div><code>_name</code> - string</div><div><code>_phonenumber</code> - uint256</div><div><code>_address</code> - address</div><div><code>_id</code> - uint256</div></dd><dt><span class="label-return">Returns:</span></dt><dd>bool</dd></dl></div></div></li><li><div class="item function"><span id="EditPlayer" class="anchor-marker"></span><h4 class="name">EditPlayer</h4><div class="body"><code class="signature">function <strong>EditPlayer</strong><span>(address _address, uint256 _id) </span><span>public </span><span>returns  (bool) </span></code><hr/><dl><dt><span class="label-parameters">Parameters:</span></dt><dd><div><code>_address</code> - address</div><div><code>_id</code> - uint256</div></dd><dt><span class="label-return">Returns:</span></dt><dd>bool</dd></dl></div></div></li><li><div class="item function"><span id="RemovePlayer" class="anchor-marker"></span><h4 class="name">RemovePlayer</h4><div class="body"><code class="signature">function <strong>RemovePlayer</strong><span>(address _address) </span><span>public </span><span>returns  (bool) </span></code><hr/><dl><dt><span class="label-modifiers">Modifiers:</span></dt><dd><a href="games_Itontine_Cplayer.html#onlyadmin">onlyadmin </a></dd><dt><span class="label-parameters">Parameters:</span></dt><dd><div><code>_address</code> - address</div></dd><dt><span class="label-return">Returns:</span></dt><dd>bool</dd></dl></div></div></li><li><div class="item function"><span id="exist" class="anchor-marker"></span><h4 class="name">exist</h4><div class="body"><code class="signature">function <strong>exist</strong><span>(address _address) </span><span>public </span><span>view </span><span>returns  (bool) </span></code><hr/><dl><dt><span class="label-parameters">Parameters:</span></dt><dd><div><code>_address</code> - address</div></dd><dt><span class="label-return">Returns:</span></dt><dd>bool</dd></dl></div></div></li><li><div class="item function"><span id="fallback" class="anchor-marker"></span><h4 class="name">fallback</h4><div class="body"><code class="signature">function <strong></strong><span>() </span><span>public </span></code><hr/></div></div></li><li><div class="item function"><span id="findplayer" class="anchor-marker"></span><h4 class="name">findplayer</h4><div class="body"><code class="signature">function <strong>findplayer</strong><span>(address _address) </span><span>public </span><span>view </span><span>returns  (string, uint, address) </span></code><hr/><dl><dt><span class="label-parameters">Parameters:</span></dt><dd><div><code>_address</code> - address</div></dd><dt><span class="label-return">Returns:</span></dt><dd>string</dd><dd>uint</dd><dd>address</dd></dl></div></div></li><li><div class="item function"><span id="getplayer" class="anchor-marker"></span><h4 class="name">getplayer</h4><div class="body"><code class="signature">function <strong>getplayer</strong><span>(address _adress) </span><span>public </span><span>view </span><span>returns  (player) </span></code><hr/><dl><dt><span class="label-parameters">Parameters:</span></dt><dd><div><code>_adress</code> - address</div></dd><dt><span class="label-return">Returns:</span></dt><dd>player</dd></dl></div></div></li></ul></div></div></div>